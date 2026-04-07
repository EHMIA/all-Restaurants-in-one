import { reviewModel } from "../Models/reviews.model.js"


const getMyReviewsService= async(userId)=>{
    const reviews= await reviewModel.find({user:userId})
                            .populate("restaurant","name coverPhoto")
                            .select("-user")
    if(reviews.length===0)return null;
    return reviews;
}


const getRestaurantReviewsService= async(restaurantId)=>{
    const restaurantReviews= await reviewModel.find({restaurant:restaurantId}).populate({
        path:'user',
        select:'firstname lastname'
    });
    if (restaurantReviews.length===0)return null;
    return restaurantReviews
}

export {
    getMyReviewsService,
    deleteMyReviewsService,
    getRestaurantReviewsService
}