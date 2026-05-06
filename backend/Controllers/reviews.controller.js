import asyncHandler from "express-async-handler"
import {  addReviewService, deleteReviewService, getMyReviewsService, getOneReviewService } from "../Services/reviews.service.js";
import { addReviewValidation } from "../Validators/restaurant.validator.js";
import { getOneRestaurantService } from "../Services/restaurant.service.js";
import mongoose from "mongoose";

// account_owner 
const getMyReviews= asyncHandler(async(req,res)=>{
    const reviews= await getMyReviewsService(req.user.id);
    if(!reviews)
        return res.status(200).json({
            message:"No reviews Found",
            Data:[]
        });
    return res.status(200).json({
        message:"Reviews retrieved successfully",
        Data:reviews
    });
});


const getOneReview= asyncHandler(async(req,res)=>{
    const review = await getOneReviewService({
        userId:req.user.id,
        restaurantId:new mongoose.Types.ObjectId(req.params.restaurantId)
    });

    if(!review)
        return res.status(200).json({
            message:"No reviews Found"
        });
    return res.status(200).json({
        message:"Review retrieved successfully",
        Data:review
    });
});

const addReview= asyncHandler(async(req,res)=>{
    const restaurantId= new mongoose.Types.ObjectId(req.params.restaurantId);
    if (!restaurantId) 
        return res.status(400).json({ message: "Restaurant ID is required" });
    const restaurant= await getOneRestaurantService(restaurantId);
    if(!restaurant)
        return res.status(404).json({message:"No such Restaurant Found"});
    console.log(restaurant);
    
    const {error}= addReviewValidation(req.body);
    if(error)
        return res.status(400).json({message:error.details[0].message});
    const review= await addReviewService(req.user.id, restaurantId, req.body);
    if(!review)
        return res.status(404).json({message:"Failed to add review"});
    return res.status(200).json({
        message:"Review Added successfully",
        data:review
    });
});

const deleteReview= asyncHandler(async(req,res)=>{
    const restaurantId= new mongoose.Types.ObjectId(req.params.restaurantId);
    if (!restaurantId) 
        return res.status(400).json({ message: "Restaurant ID is required" });
    const restaurant= await getOneRestaurantService(restaurantId);
    if(!restaurant)
        return res.status(404).json({message:"No such Restaurant Found"});
        
    const review = await deleteReviewService(req.user.id,restaurantId);
    
    if(!review)
        return res.status(404).json({message:"Failed to delete review"});
    return res.status(200).json({
        message:"Review deleted successfully",
    });
});


export{
    getMyReviews,
    getOneReview,
    addReview,
    deleteReview
}