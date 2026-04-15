import asyncHandler from "express-async-handler"
import {  addReviewService, getMyReviewsService, getOneReviewService } from "../Services/reviews.service.js";
import { addReviewValidation } from "../Validators/restaurant.validator.js";

// account_owner 
const getMyReviews= asyncHandler(async(req,res)=>{
    const reviews= await getMyReviewsService(req.user._id);
    if(!reviews)
        return res.status(404).json({message:"No reviews Found"});
    return res.status(200).json(reviews);
});


const getOneReview= asyncHandler(async(req,res)=>{
    const review = await getOneReviewService({
        userId:req.user._id,
        restaurantId:req.params.id
    });
    if(!review)
        return res.status(404).json({message:"No reviews Found"});
    return res.status(200).json({
        message:"Review retrieved successfully",
        Data:review
    });
});

const addReview= asyncHandler(async(req,res)=>{
    const {error}= addReviewValidation(req.body);
    if(error)
        return res.status(400).json({message:error.details[0].message});
    const review= await addReviewService(req.user._id, req.params.id, req.body);
    if(!review)
        return res.status(404).json({message:"No reviews Found"});
    return res.status(200).json({
        message:"Review Added successfully",
        data:review
    });
});

export{
    getMyReviews,
    getOneReview,
    addReview
}