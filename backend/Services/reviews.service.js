import mongoose from "mongoose";
import { restaurantModel } from "../Models/restaurant.model.js";
import { reviewModel } from "../Models/reviews.model.js"
import { aggragateReviewStats } from "../Utils/reviews.util.js";


const getMyReviewsService= async(userId)=>{
    const reviews= await reviewModel.find({user:userId})
                            .populate("restaurant","name coverPhoto ")
                            .select("title Content rating createdAt _id updatedAt restaurant");
    if(reviews.length===0)return null;
    return reviews;
}

const getOneReviewService= async({userId,restaurantId})=>{
    const review= await reviewModel.findOne({user:userId,restaurant:restaurantId});
    if(!review)return null;
    return review
}

    const addReviewService = async (userId, restaurantId, data) => {
    const newReview = await reviewModel.findOneAndUpdate(
        { user: userId, restaurant: restaurantId }, 
        { 
            $set:{
                title: data.title,
                Content: data.Content,
                rating: data.rating
            },
            $setOnInsert: { user: userId, restaurant: restaurantId } 
        },
        { new: true, upsert: true, runValidators: true } 
    );

    if (!newReview) return null;

    const stats = await aggragateReviewStats(restaurantId);
    
    if (stats.length > 0) {
        await restaurantModel.findByIdAndUpdate(restaurantId, {
            rating: stats[0].avgRating,
            numberOfReviews: stats[0].nRating 
        });
    }
    return newReview;
}


const deleteReviewService= async(userId,restaurantId)=>{
    const review= await reviewModel.findOneAndDelete({user:userId,restaurant:restaurantId});

    if(!review)return null;

    const stats = await aggragateReviewStats(restaurantId);
    
    if (stats.length > 0) {
        const updatedRestaurant=await restaurantModel.findByIdAndUpdate(restaurantId, {
            rating: stats[0].avgRating,
            numberOfReviews: stats[0].nRating 
        });

        if(!updatedRestaurant)
            console.log("Warning: Restaurant was not found during rating update.");
    }
    return review;
}

export {
    getMyReviewsService,
    addReviewService,
    getOneReviewService,
    deleteReviewService
}
