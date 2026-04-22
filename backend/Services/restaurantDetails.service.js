import { v2 as cloudinary } from "cloudinary";
import { uploadToCloudinary } from "../Utils/cloudinary.util.js";
import { handleRestaurantPriceRange } from "../Utils/handleRestaurantData.util.js";
import { LIMITS } from "../Utils/Constants.util.js";
import { Settings } from "../Models/adminSettings.model.js";




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
    } else {
        return restaurant;
    }
    restaurant.coverPhoto = null;
    return await restaurant.save();
};


const addDishsToMenuService = async (restaurant, menu, files) => {
    const existingDishNames = restaurant.menu.map(d => d.dishName.toLowerCase());
    
    for (let i = 0; i < menu.length; i++) {
        const newDishName = menu[i].dishName.toLowerCase();
        if (existingDishNames.includes(newDishName)) {
            throw new Error(`Dish "${menu[i].dishName}" Is already in the menu`);
        }
        const uploadResult = await uploadToCloudinary(files[i].buffer);
        restaurant.menu.push({
            ...menu[i],
            image: {
                url: uploadResult.url,
                publicId: uploadResult.publicId
            }
        });
    }
    restaurant = await handleRestaurantPriceRange(restaurant);
    return await restaurant.save();
};


const deleteDishFromMenuService = async (restaurant, dishId) => {
    const dish = restaurant.menu.id(dishId);
    if (!dish)
        return null;

    if (dish.image && dish.image.publicId)
        await cloudinary.uploader.destroy(dish.image.publicId);

    restaurant.menu.pull(dishId);
    return await restaurant.save();
}

const editDishInMenuService = async (restaurant, body, dishId, file) => {
    const dish = restaurant.menu.id(dishId);

    if (!dish)
        return null;
    
    
    if (body.dishName && body.dishName.toLowerCase() !== dish.dishName.toLowerCase()) {
        const isNameExists = restaurant.menu.some(
            d => d.dishName.toLowerCase() === body.dishName.toLowerCase() && d._id.toString() !== dishId
        );
        
        if (isNameExists) {
            throw new Error(`Dish "${body.dishName}" is already in the menu`);
        }
    }
    
    dish.price = body.price || dish.price;
    dish.dishName = body.dishName || dish.dishName;
    dish.description = body.description || dish.description;
    dish.category = body.category || dish.category;

    if (file) {
        const uploadResult = await uploadToCloudinary(file.buffer);
        if (dish.image && dish.image.publicId) {
            await cloudinary.uploader.destroy(dish.image.publicId);
        }

        dish.image = {
            url: uploadResult.url,
            publicId: uploadResult.publicId
        };
    }
    restaurant = await handleRestaurantPriceRange(restaurant);
    return await restaurant.save();
}

const addPhotosToGalleryService = async (restaurant, files) => {
    const newCount = files.length;
    const currentCount = restaurant.Gallery.length;

    if (currentCount + newCount > LIMITS.Gallery_MAX)
        throw new Error(`Adding ${newCount} photos will exceed the limit. You can only add ${LIMITS.Gallery_MAX - currentCount} more.`);

    const uploadPromises = files.map(file => uploadToCloudinary(file.buffer));
    const results = await Promise.all(uploadPromises);

    results.forEach(result => {
        restaurant.Gallery.push({
            url: result.url,
            publicId: result.publicId
        });
    });
    return await restaurant.save();
}

const deletePhotoFromGalleryService = async (restaurant, imgId) => {
    const photoExists = restaurant.Gallery.find(photo => photo._id.toString() === imgId);
    if (!photoExists)
        return null;

    const publicId = photoExists.publicId;
    await cloudinary.uploader.destroy(publicId);
    restaurant.Gallery.pull({ publicId: publicId });
    return await restaurant.save();
}

export {
    uploadOrUpdateCoverImageService,
    deleteCoverImageService,
    addDishsToMenuService,
    deleteDishFromMenuService,
    editDishInMenuService,
    addPhotosToGalleryService,
    deletePhotoFromGalleryService
}