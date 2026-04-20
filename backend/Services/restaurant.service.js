import mongoose from "mongoose";
import { restaurantModel } from "../Models/restaurant.model.js";

/**
 * @param {*}
 * @returns all restaurant
 */

/**
 * top if request
 * handle return number of reviews
 * handle if fav or no for each restaurant
 */
const getAllRestaurantsService = async (
    conditions,
    skip,
    limit,
    sort,
    UserId,
) => {
    
    let pipeline = [
        { $match: conditions },
        { $sort: sort || { createdAt: -1 } },
        { $skip: skip },
        { $limit: limit },
        {
            $lookup: {
                from: "reviews",
                localField: "_id",
                foreignField: "restaurant",
                as: "reviewsData",
            },
        },
    ];

    if (UserId) {
        pipeline.push({
            $lookup: {
                from: "favorites",
                let: { resId: "$_id" },
                pipeline: [
                    {
                        $match: {
                            $expr: {
                                $and: [
                                    { $eq: ["$restaurant", "$$resId"] },
                                    { $eq: ["$user", new mongoose.Types.ObjectId(UserId)] },
                                ],
                            },
                        },
                    },
                ],
                as: "userFavorite",
            },
        });
    }

    pipeline.push({
        $project: {
            _id: 1,
            name: 1,
            coverPhoto: 1,
            rating: 1,
            delivery: 1,
            priceRange: 1,
            cuisineType: 1,
            openingHours: 1,
            status: 1,
            reviewsCount: { $size: "$reviewsData" },

            isFavorite: UserId
                ? { $gt: [{ $size: "$userFavorite" }, 0] }
                : { $literal: false },
        },
    });

    const restaurants = await restaurantModel.aggregate(pipeline);

    const totalResNumber = await restaurantModel.countDocuments(conditions);
    if (restaurants.length === 0) return null;
    return [restaurants, totalResNumber];
};

/**
 *
 * @param {*} restaurantId
 * @param {*} returnQuery
 * @returns restaurant
 */

const getOneRestaurantService = async (restaurantId, returnQuery = null) => {
    let rawFields = [];
    if (returnQuery) {
        rawFields = Array.isArray(returnQuery) ? returnQuery : [returnQuery];
    }

    let queryFields = rawFields.map((f) => f.toLowerCase());
    const isAll = queryFields.length === 0 || queryFields.includes("all");
    const isMain = queryFields.includes("main");
    const showMainInfo = isAll || isMain;

    if (isAll) {
        queryFields = ["gallery", "menu", "reviews"];
    }

    const Restaurant = await restaurantModel.aggregate([
        {
            $match: {
                _id: new mongoose.Types.ObjectId(restaurantId),
                status: "approved",
            },
        },
        {
            $lookup: {
                from: "reviews",
                localField: "_id",
                foreignField: "restaurant",
                as: "reviewsData",
            },
        },
        {
            $project: {
                _id: 1,
                name: { $cond: [showMainInfo, "$name", "$$REMOVE"] },
                description: { $cond: [showMainInfo, "$description", "$$REMOVE"] },
                coverPhoto: { $cond: [showMainInfo, "$coverPhoto", "$$REMOVE"] },
                rating: { $cond: [showMainInfo, "$rating", "$$REMOVE"] },
                delivery: { $cond: [showMainInfo, "$delivery", "$$REMOVE"] },
                priceRange: { $cond: [showMainInfo, "$priceRange", "$$REMOVE"] },
                Owner: { $cond: [showMainInfo, "$Owner", "$$REMOVE"] },
                facebookLink: { $cond: [showMainInfo, "$facebookLink", "$$REMOVE"] },
                address: { $cond: [showMainInfo, "$address", "$$REMOVE"] },
                phoneNumber: { $cond: [showMainInfo, "$phoneNumber", "$$REMOVE"] },
                whatsappNumber: {
                    $cond: [showMainInfo, "$whatsappNumber", "$$REMOVE"],
                },
                cuisineType: { $cond: [showMainInfo, "$cuisineType", "$$REMOVE"] },
                openingHours: { $cond: [showMainInfo, "$openingHours", "$$REMOVE"] },
                status: { $cond: [showMainInfo, "$status", "$$REMOVE"] },
                Gallery: {
                    $cond: [{ $in: ["gallery", queryFields] }, "$Gallery", "$$REMOVE"],
                },
                menu: { $cond: [{ $in: ["menu", queryFields] }, "$menu", "$$REMOVE"] },
                reviews: {
                    $cond: [
                        { $in: ["reviews", queryFields] },
                        "$reviewsData",
                        "$$REMOVE",
                    ],
                },
                reviewsCount: {
                    $cond: [
                        showMainInfo,
                        { $size: { $ifNull: ["$reviewsData", []] } },
                        "$$REMOVE",
                    ],
                },
            },
        },
    ]);

    return Restaurant.length > 0 ? Restaurant[0] : null;
};

// just admins
const updateRestaurantStatus = async (id, status, AdminId, reason = null) => {
    //remember=>  here check if it is pedning if there are endPoint for change restaurant status
    const updateData = {
        status,
        [`${status}At`]: new Date(),
        [`${status}By`]: AdminId,
    };
    if (reason) updateData.rejectionReason = reason;

    const Restaurant = await restaurantModel.findByIdAndUpdate(
        id,
        {
            $set: updateData,
        },
        {
            new: true,
            runValidators: true,
        },
    );
    if (!Restaurant) return null;
    return Restaurant;
};

export {
    getAllRestaurantsService,
    getOneRestaurantService,
    updateRestaurantStatus,
};
