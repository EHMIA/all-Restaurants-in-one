import asyncHandler from "express-async-handler"
import { deleteMyReviewsService, getMyReviewsService } from "../Services/reviews.service";

// account_owner 
const getMyReviews= asyncHandler(async(req,res)=>{
    const reviews= await getMyReviewsService(req.user.id);
    if(!reviews)
        return res.status(404).json({message:"No reviews Found"});
    return res.status(200).json(reviews);
});


const getRestaurantReviews=asyncHandler(async(req,res)=>{
    
})





export{
    getMyReviews,
    deleteMyReviews
}