import asyncHandler from "express-async-handler"
import { restaurantModel } from "../Models/restaurant.model";
import { PriceRanges } from "../Utils/Constants";
import { CalculateOpenNow, createRestaurantValidation } from "../Validators/restaurant.validator";
import { getAllRestaurantsService, getOneRestaurantService, updateRestaurantStatus } from "../Services/restaurant.service";
import { getAllAdminService } from "../Services/user.service";
import { notificationModel } from "../Models/notifications.model";

// public
const getAllRestaurants = asyncHandler(async (req, res) => {
    let { Page, Limit, priceRange, rating, delivery, cuisineType } = req.query;
    Page = parseInt(Page) || 1;
    Limit = parseInt(Limit) || 10;
    const Skip = (Page - 1) * Limit;
    const PriceValidation = PriceRanges;
    const DeliveryEnum = ["true", "false"];
    const Conditions = {};

    //just get the approved restaurants
    conditions.status = "approved";
    if (rating) {
        const rating_av = parseFloat(rating);
        if (isNaN(rating_av) || rating_av > 5 || rating_av < 0) {
            return res.status(400).json({ message: "Rating is limited between 0 to 5" })
        } else {
            Conditions.rating = { $gte: rating_av };
        }
    }
    if (delivery) {
        if (!DeliveryEnum.includes(delivery.toLowerCase())) {
            return res.status(400).json({ message: "Delivery must be true or false" });
        } else {
            Conditions.delivery = delivery === "true";
        }
    }
    if (cuisineType) Conditions.cuisineType = { $in: cuisineType };
    if (priceRange) {
        if (!PriceValidation.includes(priceRange.toLowerCase())) {
            return res.status(400).json({ message: "PriceRange must be low, medium or high" });
        } else {
            Conditions.priceRange = priceRange;
        }
    }
    const [restaurants, totalResNumber] = await getAllRestaurantsService(Conditions, Skip, Limit);
    const timeNow = new Date();
    const resData = restaurants.map(res => ({
        ...res.toObject(),
        isOpen: CalculateOpenNow(res),
        serverTime: timeNow.toISOString() // YYYY-MM-DDTHH:mm:ss.sssz
    }))

    const pagesCount = Math.ceil(totalResNumber / Limit);
    res.status(200).json({
        data: resData,

        meta: {
            totalResNumber, // restaurant number
            pagesCount, // pages counter
            Page, // page number
            Limit
        }
    })
});


// public
const getOneRestaurant = asyncHandler(async (req, res) => {
    const Restaurant = await getOneRestaurantService(req.params.id);
    if (!Restaurant)
        return res.status(404).json({ message: "Restaurant not found" })
    res.status(200).json(({
        ...Restaurant.toObject(),
        isOpen: CalculateOpenNow(Restaurant),
        serverTime: timeNow.toISOString() // YYYY-MM-DDTHH:mm:ss.sssz
    }));
});


// for admin or user=>to owner
const createNewRestaurant = asyncHandler(async (req, res) => {
    const { error } = createRestaurantValidation(req.body);
    if (error)
        return res.status(400).json({ message: error.details[0].message });

    const existingRestaurant = await restaurantModel.findOne({ Owner: req.user.id });
    if (existingRestaurant)
        return res.status(400).json({ message: "You already have a restaurant" });

    const {
        email, name, coverPhoto, rating, delivery,
        priceRange, facebookLink, cuisineType, phoneNumber,
        whatsappNumber, address, Gallery, menu, openingHours
    } = req.body;

    const newRestaurant = new restaurantModel({
        email, name, coverPhoto, rating, delivery,
        priceRange, facebookLink, cuisineType, phoneNumber,
        whatsappNumber, address, Gallery, menu, openingHours,
        Owner: req.user.id
    });

    if (req.user.role === "admin") {
        newRestaurant.status = "approved";
        newRestaurant.approvedAt = new Date(); 
        newRestaurant.approvedBy = req.user.id;
        const savedRestaurant = await newRestaurant.save();
        res.status(201).json(savedRestaurant);
    } else {
        newRestaurant.status = "pending";
        const savedRestaurant = await newRestaurant.save();

        const admins = await getAllAdminService();
        if (!admins || admins.length === 0)
            return res.status(404).json({ message: "No admins found" });

        const notifications = admins.map((admin) => ({
            sender: req.user.id,
            message: `new restaurant request from ${req.user.name}`,
            receiver: admin._id,
            type: "pending",
            restaurant: savedRestaurant._id
        }));
        await notificationModel.insertMany(notifications);
        res.status(201).json(savedRestaurant);
    }
});


// admin accpet or reject a request
// send sender id in the url
const acceptRejectRequest = asyncHandler(async (req, res) => {
    const { action, reason } = req.body;
    const restaurantId = req.params.id;
    const AdminId=req.user.id;
    const restaurant = await getOneRestaurantService(restaurantId);
    if (!restaurant)
        return res.status(404).json({ message: "No restaurant found" });

    if (action === "accept") {
        await updateRestaurantStatus(restaurantId, "approved",AdminId);
        await notificationModel.create({
            sender: req.user.id, // admin
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
        await updateRestaurantStatus(restaurantId, "rejected",AdminId, reason);
        await notificationModel.create({
            sender: req.user.id, // admin
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
    acceptRejectRequest
}