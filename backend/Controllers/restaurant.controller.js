import asyncHandler from "express-async-handler"
import { restaurantModel } from "../Models/restaurant.model.js";
import { CuisineTypes, DeliveryEnum, PriceRanges } from "../Utils/Constants.util.js";
import {  createRestaurantValidation, editRestaurantMainDataValidation } from "../Validators/restaurant.validator.js";
import { editRestaurantMainDataService, getAllRestaurantsService, getOneRestaurantService, updateRestaurantStatus } from "../Services/restaurant.service.js";
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
    let { Page, Limit, priceRange, minRating, delivery, cuisineType, Top , searchQuery } = req.query;

    
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
    
    if (searchQuery) {
    Conditions.name = { $regex: String(searchQuery), $options: "i" };
}
    
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

    const UserId = req.user ? req.user.id : null;
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
    const restaurantId = req.params.restaurantId;
    const Restaurant = await getOneRestaurantService(restaurantId, "main", req.user || null);

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
    const restaurantId = req.params.restaurantId;
    const selection = req.query.select;

    if (!selection) return res.status(400).json({ message: "Selection query is required" });

    const Restaurant = await getOneRestaurantService(restaurantId, selection, req.user || null);
    
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
    if (!coverFile) return res.status(400).json({ message: "Restaurant cover photo is required" });

    const validationBody = { ...req.body, coverPhoto: coverFile };

    const { error, value } = createRestaurantValidation(validationBody);
    if (error) return res.status(400).json({ message: error.details[0].message });

    const existingOwner = await restaurantModel.findOne({ Owner: req.user.id });
    if (existingOwner) {
        const msg = existingOwner.status === "pending"
            ? "You already have a pending restaurant request"
            : existingOwner.status === "approved"
                ? "You already have a restaurant"
                : "Your previous request was rejected. Please review and update your existing data instead of creating a new one";

        return res.status(400).json({ message: msg, Data: { restaurantId: existingOwner._id } });
    }

    const existingEmail = await restaurantModel.findOne({ email: req.body.email });
    if (existingEmail) return res.status(400).json({ message: "This Restaurant Email Already exists" });

    const coverPhotoData = await uploadToCloudinary(coverFile.buffer);

    const newRestaurant = new restaurantModel({
        ...value,
        coverPhoto: coverPhotoData,
        Owner: req.user.id,
        status: "pending"
    });

    const savedRestaurant = await newRestaurant.save();

    res.status(201).json({
        message: "Your request has been sent successfully and is awaiting admin approval",
        restaurant: savedRestaurant
    });
});



const editRestaurantMainData = asyncHandler(async (req, res) => {
    const restaurant = req.restaurant;     
    const { error, value } = editRestaurantMainDataValidation(req.body);
    
    if (error) 
        return res.status(400).json({ message: error.details[0].message });

    console.log(restaurant.status);
    
    const updatedRestaurant = await editRestaurantMainDataService(restaurant, value);
    
    if (!updatedRestaurant) {
        return res.status(500).json({ message: "Failed to update restaurant data" });
    }

    res.status(200).json({
        message: "Restaurant data updated successfully",
        restaurant: updatedRestaurant
    });
});


//FOR OWNER
const getMyRestaurantDashboard = asyncHandler(async (req, res) => {
    const restaurant = await restaurantModel.findOne({ Owner: req.user.id });
    if (!restaurant) {
        return res.status(404).json({ message: "You don't have a restaurant" });
    }

    return res.status(200).json({
        message: "Restaurant retrieved successfully",
        Data: restaurant 
    });
});

const deleteRestaurant = asyncHandler(async (req, res) => {
    const restaurant = await restaurantModel.findOne({ Owner: req.user.id });
    if (!restaurant) {
        return res.status(404).json({ message: "You don't have a restaurant" });
    }

    const deletedRes = await deleteRestaurantService(restaurant._id,req.user.id);
    if (!deletedRes) {
        return res.status(404).json({ message: "Restaurant not found" });
    }
    res.status(200).json({ message: "Restaurant deleted successfully" });
});

export {
    createNewRestaurant,
    getAllRestaurants,
    getOneRestaurant,
    getSelectionRestaurant,
    editRestaurantMainData,
    getMyRestaurantDashboard,
    deleteRestaurant
}