import { v2 as cloudinary } from "cloudinary";
import { uploadToCloudinary } from "../Utils/cloudinary.js";

const uploadOrUpdateCoverImageService = async (restaurant, fileBuffer) => {
    if (restaurant.coverPhoto && restaurant.coverPhoto.publicId) {
        await cloudinary.uploader.destroy(restaurant.coverPhoto.publicId);
    }
    const uploadResult = await uploadToCloudinary(fileBuffer);
    restaurant.coverPhoto = uploadResult;
    return await restaurant.save();
};


const deleteCoverImageService = async (restaurant) => {
    if (restaurant.coverPhoto && restaurant.coverPhoto.publicId) {
        await cloudinary.uploader.destroy(restaurant.coverPhoto.publicId);
    }else{
        return restaurant;
    }
    restaurant.coverPhoto = null;
    return await restaurant.save();
};

export{
    uploadOrUpdateCoverImageService,
    deleteCoverImageService
}