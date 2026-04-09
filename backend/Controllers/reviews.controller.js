import asyncHandler from "express-async-handler"
import {  getMyReviewsService, getRestaurantReviewsService } from "../Services/reviews.service.js";

// account_owner 
const getMyReviews= asyncHandler(async(req,res)=>{
    const reviews= await getMyReviewsService(req.user._id);
    if(!reviews)
        return res.status(404).json({message:"No reviews Found"});
    return res.status(200).json(reviews);
});

export{
    getMyReviews,
    
}