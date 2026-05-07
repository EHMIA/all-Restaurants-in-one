import mongoose from "mongoose";
import { reviewModel } from "../Models/reviews.model.js";


const aggragateReviewStats = async (restaurantId) => {
    const stats = await reviewModel.aggregate([
        { $match: { restaurant: new mongoose.Types.ObjectId(restaurantId) } },
        {
            $group: {
                _id: "$restaurant",
                avgRating: { $avg: "$rating" },  
                nRating: { $sum: 1 }, 
            },
        },
    ]);
    return stats;
};

export { aggragateReviewStats}