import { restaurantModel } from "../Models/restaurant.model";
import { getRestaurantReviewsService } from "./reviews.service";

/**
 * @param {*} 
 * @returns all restaurant
 */

/**
 * top if request
 * handle return number of reviews
 * handle if fav or no for each restaurant
 */
const getAllRestaurantsService = async (conditions, skip, limit) => {
    const [restaurants, totalResNumber] = await Promise.all([
        restaurantModel.find(conditions).skip(skip).limit(limit)
            .select("_id name coverPhoto rating delivery priceRange cuisineType openingHours status"),
        restaurantModel.countDocuments(conditions)
    ]);
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
        const Restaurant = await restaurantModel.findOne({
            _id: restaurantId,
            status: "approved"
        }).select(`name description coverPhoto rating delivery priceRange Owner facebookLink address phoneNumber whatsappNumber cuisineType openingHours status ${returnQuery=="Gallery"|| returnQuery=="menu" ? returnQuery : returnQuery=="all" ? ["Gallery", "menu"]:""}`);


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
