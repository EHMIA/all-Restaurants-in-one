import mongoose from "mongoose";
import { restaurantModel } from "../Models/restaurant.model.js";
import { reviewModel } from "../Models/reviews.model.js";
import { favResModel } from "../Models/FavoriteRestaurants.model.js";
import { Users } from "../Models/user.model.js";

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
            description: 1,
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
 * @param {*} restaurantId
 * @param {*} returnQuery
 * @returns restaurant
 */

const getOneRestaurantService = async (restaurantId, returnQuery = null, user) => {
    let queryFields = (Array.isArray(returnQuery) ? returnQuery : [returnQuery])
        .filter(Boolean)
        .map(f => f.toLowerCase());

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
                status: "approved" 
            },
        },
        {
            $lookup: {
                from: "reviews",
                localField: "_id",
                foreignField: "restaurant",
                as: "reviewsData",
                pipeline: [
                    {
                        $lookup: {
                            from: "users",
                            localField: "user",
                            foreignField: "_id",
                            as: "userData",
                        },
                    },
                    {
                        $unwind: {
                            path: "$userData",
                            preserveNullAndEmptyArrays: true
                        }
                    },
                    {
                        $addFields: {
                            user:{
                                $cond: {
                                if: { $not: ["$userData"] },
                                then: { _id: "$user", name: "Deleted User", profile: null },
                                else: {
                                    _id: "$user",
                                    name: "$userData.fullname",
                                    profile: { $ifNull: ["$userData.profile_pic", null] }
                                }
                            }
                            }
                        }
                    },
                    {
                        $project: {
                            userData: 0
                        }
                    }
                ]
            },
        },{
            $lookup: {
                from: "favorites",
                let: { resId: "$_id" },
                pipeline: [
                    {
                        $match: {
                            $expr: {
                                $and: [
                                    { $eq: ["$restaurant", "$$resId"] },
                                    { $eq: ["$user", user?.id ? new mongoose.Types.ObjectId(user.id) : null] },
                                ],
                            },
                        },
                    },
                ],
                as: "userFavorite",
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
                whatsappNumber: { $cond: [showMainInfo, "$whatsappNumber", "$$REMOVE"] },
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
                userFavoriteData: { $cond: [showMainInfo, "$userFavorite", "$$REMOVE"] },
            },
        },
    ]);
    return Restaurant.length > 0 ? Restaurant[0] : null;
};


const editRestaurantMainDataService = async (restaurant, data) => {
    const updatePayload = { ...data };
    
    if (restaurant.status && restaurant.status.trim().toLowerCase() === "rejected") {
        updatePayload.status = "pending";
        updatePayload.rejectionReason = null; 
        updatePayload.rejectedBy = null;
    }

    const updatedRestaurant = await restaurantModel.findByIdAndUpdate(
        restaurant._id,
        { $set: updatePayload }, 
        {
            new: true, 
            runValidators: true,
        }
    );
    return updatedRestaurant;
};

// just admins 
const updateRestaurantStatus = async (id, status, AdminId, reason = null) => {
    const updateData = {
        status,
        [`${status}At`]: new Date(),
        [`${status}By`]: AdminId,
    };
    if (reason) updateData.rejectionReason = reason;

    
    const updateQuery = { $set: updateData };

    if (status === "rejected") {
        updateQuery.$inc = { rejectionCount: 1 };
    }

    const Restaurant = await restaurantModel.findByIdAndUpdate(
        id,
        updateQuery, 
        {
            returnDocument: 'after', 
            runValidators: true,
        },
    );
    return Restaurant;
};

const deleteRestaurantService = async(restaurantId, ownerId)=>{
    await reviewModel.deleteMany({ restaurant: restaurantId });
    await favResModel.deleteMany({ restaurant: restaurantId });
    const user= await Users.findByIdAndUpdate(ownerId,{
        role:"user"
    });
    const deletedRestaurant =await restaurantModel.findByIdAndDelete(restaurantId);
    if(!deletedRestaurant)
        return null;
    return deletedRestaurant;
}



export {
    getAllRestaurantsService,
    getOneRestaurantService,
    updateRestaurantStatus,
    editRestaurantMainDataService
};

