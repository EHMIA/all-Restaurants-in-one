import mongoose from "mongoose";
import { restaurantModel } from "../Models/restaurant.model.js";
import { reviewModel } from "../Models/reviews.model.js";
import { aggragateReviewStats } from "../Utils/reviews.util.js";

const getMyReviewsService = async (userId) => {
    const reviews = await reviewModel
        .find({ user: userId })
        .populate("restaurant", "name coverPhoto ")
        .select("Content rating createdAt _id");
    if (reviews.length === 0) return null;
    return reviews;
};

const getOneReviewService = async ({ userId, restaurantId }) => {
    const review = await reviewModel
        .findOne({ user: userId, restaurant: restaurantId })
        .populate("restaurant", "name coverPhoto ")
        .select("Content rating createdAt _id");
    if (!review) return null;
    return review;
};

const addReviewService = async (userId, restaurantId, data) => {
    const newReview = await reviewModel
        .findOneAndUpdate(
            { user: userId, restaurant: restaurantId },
            {
                $set: {
                    Content: data.Content,
                    rating: data.rating,
                },
                $setOnInsert: { user: userId, restaurant: restaurantId },
            },
            { new: true, upsert: true, runValidators: true },
        )
        .populate("restaurant", "name coverPhoto")
        .select("Content rating createdAt _id restaurant");

    if (!newReview) return null;

    const stats = await aggragateReviewStats(restaurantId);

    if (stats.length > 0) {
        await restaurantModel.findByIdAndUpdate(restaurantId, {
            rating: stats[0].avgRating,
            numberOfReviews: stats[0].nRating,
        });
    } else {
        await restaurantModel.findByIdAndUpdate(restaurantId, {
            rating: 0,
            numberOfReviews: 0,
        });
    }
    return newReview;
};

const deleteReviewService = async (userId, restaurantId) => {
    const review = await reviewModel.findOneAndDelete({
        user: userId,
        restaurant: restaurantId,
    });

    if (!review) return null;

    const stats = await aggragateReviewStats(restaurantId);

    const avgRating = stats.length > 0 ? stats[0].avgRating : 0;
    const nRating = stats.length > 0 ? stats[0].nRating : 0;

    await restaurantModel.findByIdAndUpdate(
        restaurantId,
        {
            rating: avgRating,
            numberOfReviews: nRating,
        }
    );
    return review;
};

export {
    getMyReviewsService,
    addReviewService,
    getOneReviewService,
    deleteReviewService,
};
