import asyncHandler from "express-async-handler";
import { deleteCoverImageService, uploadOrUpdateCoverImageService } from "../Services/restaurantDetails.service.js";
import { getOneRestaurantService } from "../Services/restaurant.service.js";

const uploadOrUpdateCoverImage = asyncHandler(async (req, res) => {
    const  restaurant = req.restaurant;
    const file = req.file;

    if (!file) 
        return res.status(400).json({ message: "Cover image is required" });
    const updatedRestaurant = await uploadOrUpdateCoverImageService(restaurant, file.buffer);

    if (!updatedRestaurant) 
        return res.status(500).json({ message: "Failed to update cover image" });

    res.status(200).json({
        message: "Cover image updated successfully",
        coverPhoto: updatedRestaurant.coverPhoto
    });
});

const deleteCoverImage = asyncHandler(async (req, res) => {
    const  restaurant = req.restaurant;
    
    const restaurantWithOutCover = await deleteCoverImageService(restaurant);

    if (!restaurantWithOutCover) 
        return res.status(500).json({ message: "Failed to delete cover image" });

    res.status(200).json({
        message: "Cover image deleted successfully",
        coverPhoto: restaurantWithOutCover.coverPhoto
    });
});


export{
    uploadOrUpdateCoverImage,
    deleteCoverImage
}