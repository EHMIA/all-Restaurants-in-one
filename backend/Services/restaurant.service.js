import { restaurantModel } from "../Models/restaurant.model.js";
import { getRestaurantReviewsService } from "./reviews.service.js";

/**
 * @param {*} 
 * @returns all restaurant
 */

/**
 * top if request
 * handle return number of reviews
 * handle if fav or no for each restaurant
 */
const getAllRestaurantsService = async (conditions, skip, limit, sort, UserId) => {
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
                as: "reviewsData"
            }
        }
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
                                    { $eq: ["$user", new mongoose.Types.ObjectId(UserId)] } 
                                ]
                            }
                        }
                    }
                ],
                as: "userFavorite"
            }
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
                : { $literal: false } 
        }
    });

    const restaurants = await restaurantModel.aggregate(pipeline);

    const totalResNumber = await restaurantModel.countDocuments(conditions);
    if (restaurants.length === 0) return null;
    return [restaurants, totalResNumber];
}

/**
 * 
 * @param {*} restaurantId 
 * @param {*} returnQuery 
 * @returns restaurant
 */

/**
 * handle return user name for each review in case of "reviews" and "all"
 * handle return number of reviews
 * handle if fav or no
 */
const getOneRestaurantService = async (restaurantId, returnQuery) => {

    let queryFields = [];
    if (returnQuery === "all") {
        queryFields = ["Gallery", "menu", "reviews"];
    } else if (Array.isArray(returnQuery)) {
        queryFields = returnQuery;
    } else if (returnQuery) {
        queryFields = [returnQuery];
    }
        const Restaurant = await restaurantModel.aggregate([
        {
            $match: {   
                _id: new mongoose.Types.ObjectId(restaurantId),
                status: "approved"
            }
        },
        {
            $lookup: {
                from: "reviews",
                localField: "_id",
                foreignField: "restaurant",
                as: "reviewsData"
            }
        },
        {
            $project: {
                _id: 1,
                name: 1,
                description: 1,
                coverPhoto: 1,
                rating: 1,
                delivery: 1,
                priceRange: 1,
                Owner: 1,
                facebookLink: 1,
                address: 1,
                phoneNumber: 1,
                whatsappNumber: 1,
                cuisineType: 1,
                openingHours: 1,                
                status: 1,
                Gallery: { $cond: [ { $in: [ "Gallery", queryFields ] }, "$Gallery", "$$REMOVE" ] },
                menu: { $cond: [ { $in: [ "menu", queryFields ] }, "$menu", "$$REMOVE" ] },
                reviews: { $cond: [ { $in: [ "reviews", queryFields ] }, "$reviewsData", "$$REMOVE" ] },
                reviewsCount: { $size: "$reviewsData" },
                isFavorite: { $gt: [{ $size: "$userFavorite" }, 0] }
            }
        }
    ]);
        
    
        // findOne({
        //     _id: restaurantId,
        //     status: "approved"
        // }).select(`name description coverPhoto rating delivery priceRange Owner facebookLink address phoneNumber whatsappNumber cuisineType openingHours status ${returnQuery=="Gallery"|| returnQuery=="menu" ? returnQuery : returnQuery=="all" ? ["Gallery", "menu"]:""}`);


        let restaurantReviews= await getRestaurantReviewsService(restaurantId);
        if(returnQuery=="reviews" || returnQuery=="all"){
            if(!restaurantReviews){
                restaurantReviews=[];
            }
        }
    if (!Restaurant) return null;
    if(returnQuery=="reviews" || returnQuery=="all"){
        return {
        Restaurant,
        restaurantReviews,
        restaurantReviewsCount:restaurantReviews.length
    };
    }else{
        return {
        Restaurant,
        restaurantReviewsCount:restaurantReviews.length
    };
    }
}

// just admins
const updateRestaurantStatus = async (id, status, AdminId, reason = null) => {
    //remember=>  here check if it is pedning if there are endPoint for change restaurant status
    const updateData = {
        status,
        [`${status}At`]: new Date(),
        [`${status}By`]: AdminId
    };
    if (reason) updateData.rejectionReason = reason;

    const Restaurant = await restaurantModel.findByIdAndUpdate(id,
        {
            $set: updateData
        }
        ,
        {
            new: true,
            runValidators: true
        }
    );
    if (!Restaurant) return null;
    return Restaurant;
}


export {
    getAllRestaurantsService,
    getOneRestaurantService,
    updateRestaurantStatus,
}
