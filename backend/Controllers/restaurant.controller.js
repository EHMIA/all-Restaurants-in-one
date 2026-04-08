import asyncHandler from "express-async-handler"
import { restaurantModel } from "../Models/restaurant.model.js";
import { DeliveryEnum, PriceRanges } from "../Utils/Constants.js";
import { CalculateOpenNow, createRestaurantValidation } from "../Validators/restaurant.validator.js";
import { getAllRestaurantsService, getOneRestaurantService, updateRestaurantStatus } from "../Services/restaurant.service.js";
import { getAllAdminService } from "../Services/user.service.js";
import { notificationModel } from "../Models/notifications.model.js";
import { uploadToCloudinary } from "../Utils/cloudinary.js";

/**
 * @desc get all restaurants
 * @Method GET
 * @Route /restaurants?Page=1&Limit=10&priceRange=low&minRating=5&delivery=yes&cusineType=egyption
 * @Access public
 */


const getAllRestaurants = asyncHandler(async (req, res) => {
    let { Page, Limit, priceRange, minRating, delivery, cuisineType, Top } = req.query;

    Page = parseInt(Page) || 1;
    Limit = parseInt(Limit) || 10;
    const Skip = (Page - 1) * Limit;
    const PriceValidation = PriceRanges;
    const Conditions = {};

    //just get the approved restaurants
    Conditions.status = "approved";
    if (minRating) {
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
    if (!restaurants)
        return res.status(404).json({ message: "No Restaurants Found" });

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


const getOneRestaurant = asyncHandler(async (req, res) => {
    const Query = req.query;
    const restaurantId = req.params.id;
    let returnQuery;
    if (Query == null) {
        returnQuery = null;
    } else if (Query = "Gallery") {
        returnQuery = "Gallery";
    } else if (Query = "reviews") {
        returnQuery = "reviews";
    } else if (Query = "menu") {
        returnQuery = "menu";
    } else if (Query == "all") {
        returnQuery == "all"
    } else {
        return res.status(404).json({ message: "Invalid Query" });
    }
    const Restaurant = await getOneRestaurantService(restaurantId, returnQuery);
    if (!Restaurant)
        return res.status(404).json({ message: "Restaurant not found" });
    console.log(Restaurant);
    
    res.status(200).json(({
        ...Restaurant.toObject(),
        isOpen: CalculateOpenNow(Restaurant),
        serverTime: timeNow.toISOString() // YYYY-MM-DDTHH:mm:ss.sssz
    }));
});


const createNewRestaurant = asyncHandler(async (req, res) => {
    if (typeof req.body.address === 'string') req.body.address = JSON.parse(req.body.address);
    if (typeof req.body.openingHours === 'string') req.body.openingHours = JSON.parse(req.body.openingHours);
    if (typeof req.body.cuisineType === 'string') req.body.cuisineType = JSON.parse(req.body.cuisineType);


    if (req.body.delivery) {
        if (!DeliveryEnum.includes(req.body.delivery.toLowerCase())) {
            return res.status(400).json({ message: "Delivery must be true or false" });
        } else {
            req.body.delivery = (req.body.delivery === "1" || req.body.delivery === "true");
        }
    }

const tempBody = { ...req.body };
    
    const galleryFiles = req.files?.["gallery"] || req.files?.["Gallery"]; 
    const coverFile = req.files?.["coverImage"];

    if (galleryFiles) tempBody.Gallery = new Array(galleryFiles.length).fill("temp_url");
    if (coverFile) tempBody.coverPhoto = "temp_url";

    
    const { error, value }= createRestaurantValidation(tempBody);
    if (error) return res.status(400).json({ message: error.details[0].message });

    const finalData = { ...value };
    delete finalData.Gallery;

    const existingOwner = await restaurantModel.findOne({ Owner: req.user._id });
    if (existingOwner) {
        if(existingOwner.status === "pending"){
            return res.status(400).json({ message: "You already have a pending restaurant request" });
        }else if(existingOwner.status === "approved"){
            return res.status(400).json({ message: "You already have a restaurant" });
        }else{
            return res.status(400).json(
                { 
                    message: "Your previous request was rejected. Please review and update your existing data instead of creating a new one" ,
                    resturantId: existingOwner._id
                }
            );
        }
    }

    const existingRestaurant = await restaurantModel.findOne({ email: req.body.email });
    if (existingRestaurant) return res.status(400).json({ message: "This Restaurant Already exists" });

    let coverImageUrl = null;
    if (coverFile) {
        coverImageUrl = await uploadToCloudinary(coverFile[0].buffer);
    }

    let galleryUrls = [];
    if (galleryFiles) {
        galleryUrls = await Promise.all(
            galleryFiles.map(file => uploadToCloudinary(file.buffer))
        );
    }

    const newRestaurant = new restaurantModel({
        ...finalData, 
        coverPhoto: coverImageUrl,
        Gallery: galleryUrls, 
        Owner: req.user._id,
    });

    if (req.user.role === "admin") {
        newRestaurant.status = "approved";
        newRestaurant.approvedAt = new Date();
        newRestaurant.approvedBy = req.user._id;
    } else {
        newRestaurant.status = "pending";
    }

    const savedRestaurant = await newRestaurant.save();

    if (req.user.role !== "admin") {
        const admins = await getAllAdminService();
        if (admins && admins.length > 0) {
            const notifications = admins.map(admin => ({
                sender: req.user._id,
                message: `New restaurant request from ${req.user.name}`,
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



// Edit Restaurant Data

const editRestaurantMainData = asyncHandler(async (req, res) => {

})





export {
    createNewRestaurant,
    getAllRestaurants,
    getOneRestaurant,
    acceptRejectRequest,
    editRestaurantMainData
}