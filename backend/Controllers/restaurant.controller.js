import asyncHandler from "express-async-handler"
import { restaurantModel } from "../Models/restaurant.model.js";
import { CuisineTypes, DeliveryEnum, PriceRanges } from "../Utils/Constants.util.js";
import {  createRestaurantValidation } from "../Validators/restaurant.validator.js";
import { getAllRestaurantsService, getOneRestaurantService, updateRestaurantStatus } from "../Services/restaurant.service.js";
import { getAllAdminService } from "../Services/user.service.js";
import { notificationModel } from "../Models/notifications.model.js";
import { uploadToCloudinary } from "../Utils/cloudinary.util.js";
import { CalculateOpenNow } from "../Utils/handleRestaurantData.util.js";

/**
 * @desc get all restaurants
 * @Method GET
 * @Route /restaurants?Page=1&Limit=10&priceRange=low&minRating=5&delivery=yes&cusineType=egyption
 * @Access public
 */

const getAllRestaurants = asyncHandler(async (req, res) => {
    let { Page, Limit, priceRange, minRating, delivery, cuisineType, Top } = req.query;

    
    let Conditions = { status: "approved" };
    let Sort = {};

    if (Top) {
        const topLimit = parseInt(Top) || 5;
        Page = 1;
        Limit = topLimit;
        Sort = { rating: -1 };
    } else {
        Page = parseInt(Page) || 1;
        Limit = parseInt(Limit) || 10;
        Sort = { createdAt: -1 };
    }

    const Skip = (Page - 1) * Limit;


    if (minRating) {
        const rating_av = parseFloat(minRating);
        if (isNaN(rating_av) || rating_av > 5 || rating_av < 0) {
            return res.status(400).json({ message: "Rating must be between 0 and 5" });
        }
        Conditions.rating = { $gte: rating_av };
    }

        
    if (delivery) {
        Conditions.delivery = delivery === "true";
    }

    if (cuisineType) {
        const cuisineArray = Array.isArray(cuisineType) ? cuisineType : [cuisineType];

        const isValid = cuisineArray.every(type => CuisineTypes.includes(type));

        if (!isValid) {
            return res.status(400).json({
                message: `Invalid cuisine type. Available types are:
                { ${CuisineTypes.join(", ")}
            }`
            });
        }

        Conditions.cuisineType = { $in: cuisineArray };
    }
    if (priceRange) {
        Conditions.priceRange = priceRange.toLowerCase();
    }

    
    
    

    const UserId = req.user ? req.user._id : null;
    const result = await getAllRestaurantsService(Conditions, Skip, Limit, Sort, UserId);

    if (!result)
        return res.status(200).json({
            message: "No Restaurants Found",
            Data: [],
            meta: {
                totalResNumber: 0,
                pagesCount: 0,
                Page: Page,
                Limit: Limit
            }
        });
    const [restaurants, totalResNumber] = result;

    const now = new Date().toISOString();
    const resData = restaurants.map(res => ({
        ...res,
        isOpen: CalculateOpenNow(res),
        serverTime: now
    }));



    res.status(200).json({
        message: "Restaurants retrieved successfully",
        Data: resData,
        meta: {
            totalResNumber: totalResNumber,
            pagesCount: Math.ceil(totalResNumber / Limit),
            Page: Page,
            Limit: Limit
        }
    });
});


const getOneRestaurant = asyncHandler(async (req, res) => {
    const restaurantId = req.params.id;
    const Restaurant = await getOneRestaurantService(restaurantId, "main");

    if (!Restaurant) return res.status(404).json({ message: "Restaurant not found" });

    res.status(200).json({
        message: "Restaurant retrieved successfully",
        Data: {
            ...Restaurant,
            isOpen: CalculateOpenNow(Restaurant),
            serverTime: new Date().toISOString()
        }
    });
});

const getSelectionRestaurant = asyncHandler(async (req, res) => {
    const restaurantId = req.params.id;
    const selection = req.query.select;

    if (!selection) return res.status(400).json({ message: "Selection query is required" });

    const Restaurant = await getOneRestaurantService(restaurantId, selection);
    
    if (!Restaurant) return res.status(404).json({ message: "Restaurant not found" });

    res.status(200).json({
        message: "Restaurant retrieved successfully",
        Data: Restaurant
    });
});

const createNewRestaurant = asyncHandler(async (req, res) => {
    if (typeof req.body.address === 'string') req.body.address = JSON.parse(req.body.address);
    if (typeof req.body.openingHours === 'string') req.body.openingHours = JSON.parse(req.body.openingHours);
    if (typeof req.body.cuisineType === 'string') req.body.cuisineType = JSON.parse(req.body.cuisineType);

    if (req.body.delivery) {
        req.body.delivery = (req.body.delivery === "1" || req.body.delivery === "true");
    }

    const coverFile = req.file;
    const validationBody = {
        ...req.body,
        coverPhoto: coverFile,
    };

    const { error, value } = createRestaurantValidation(validationBody);
    if (error) return res.status(400).json({ message: error.details[0].message });


    const existingOwner = await restaurantModel.findOne({ Owner: req.user._id });
    if (existingOwner) {
        const msg = existingOwner.status === "pending"
            ? "You already have a pending restaurant request"
            : existingOwner.status === "approved"
                ? "You already have a restaurant"
                : "Your previous request was rejected. Please review and update your existing data instead of creating a new one";

        return res.status(400).json({ message: msg, Data: { restaurantId: existingOwner._id } });
    }

    const existingRestaurant = await restaurantModel.findOne({ email: req.body.email });
    if (existingRestaurant) return res.status(400).json({ message: "This Restaurant Already exists" });

    const coverPhotoData = await uploadToCloudinary(coverFile.buffer);

    const newRestaurant = new restaurantModel({
        ...value,
        coverPhoto: coverPhotoData,
        Gallery: [],
        Owner: req.user.id,
    });

    if (req.user.role === "admin") {
        newRestaurant.status = "approved";
        newRestaurant.approvedAt = new Date();
        newRestaurant.approvedBy = req.user.id;
    } else {
        newRestaurant.status = "pending";
    }

    const savedRestaurant = await newRestaurant.save();

    if (req.user.role !== "admin") {
        const admins = await getAllAdminService();
        if (admins?.length > 0) {
            const notifications = admins.map(admin => ({
                sender: req.user.id,
                message: `New restaurant request from ${req.user.fullname || req.user.name}`,
                receiver: admin._id,
                type: "pending",
                restaurant: savedRestaurant._id
            }));
            await notificationModel.insertMany(notifications);
        }
    }

    res.status(201).json({
        message: req.user.role === "admin"
            ? "Restaurant created and approved successfully"
            : "Your request has been sent successfully and is awaiting admin approval",
        restaurant: savedRestaurant
    });
});


// admin accpet or reject a request
// send sender id in the url
const acceptRejectRequest = asyncHandler(async (req, res) => {
    const { action, reason } = req.body;
    const restaurantId = req.params.id;
    const AdminId = req.user._id;
    const restaurant = await getOneRestaurantService(restaurantId);
    if (!restaurant)
        return res.status(404).json({ message: "No restaurant found" });

    if (action === "accept") {
        await updateRestaurantStatus(restaurantId, "approved", AdminId);
        await notificationModel.create({
            sender: req.user._id, // admin
            message: `Your request has been approved and now you are Owner`,
            receiver: restaurant.Owner,
            type: "approved"
        });

        const restaurantOwner = await getOneUserService(restaurant.Owner);
        if (!restaurantOwner)
            return res.status(404).json({ message: "No user found" });

        restaurantOwner.role = "owner";
        await restaurantOwner.save();
        res.status(200).json({ message: "Request accepted" });
    } else if (action === "reject") {
        if (!reason || !reason.trim()) {
            return res.status(400).json({
                message: "Reason is required and must not be empty"
            });
        }
        await updateRestaurantStatus(restaurantId, "rejected", AdminId, reason);
        await notificationModel.create({
            sender: req.user._id, // admin
            message: `Your request has been rejected Because ${reason}`,
            restaurant: restaurantId,
            receiver: restaurant.Owner,
            type: "rejected"
        });
        res.status(200).json({ message: "Request rejected" });
    } else if (action === "pending") {
        return res.status(400).json({ message: "This request is already pending" });
    }
    // pending state ? 
});





export {
    createNewRestaurant,
    getAllRestaurants,
    getOneRestaurant,
    acceptRejectRequest,
    getSelectionRestaurant
}