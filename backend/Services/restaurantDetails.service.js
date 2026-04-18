import { v2 as cloudinary } from "cloudinary";
import { uploadToCloudinary } from "../Utils/cloudinary.util.js";
import { handleRestaurantPriceRange } from "../Utils/handleRestaurantData.util.js";




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

    let settings_ = await Settings.findOne();

    if (!settings_)
        throw new Error("Admin settings not found");


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
    restaurant=await handleRestaurantPriceRange(restaurant);
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

    if(dish.dishName)
    {
        const existingDishNames = restaurant.menu.map(d => d.dishName.toLowerCase());
        if (existingDishNames.includes(dish.dishName.toLowerCase())) {
            throw new Error(`Dish "${dish.dishName}" Is already in the menu`);
        }
    }

    if (dish.image && dish.image.publicId)
        await cloudinary.uploader.destroy(dish.image.publicId);
    if (file){
    const uploadResult = await uploadToCloudinary(file.buffer);
    dish.image = {
        url: uploadResult.url,
        publicId: uploadResult.publicId
    }}
    dish.price = body.price || dish.price;
    dish.dishName = body.dishName || dish.dishName;
    dish.description = body.description || dish.description;
    dish.category = body.category || dish.category;
    
    
    restaurant=await handleRestaurantPriceRange(restaurant);
    return await restaurant.save();
}


export {
    uploadOrUpdateCoverImageService,
    deleteCoverImageService,
    addDishsToMenuService,
    deleteDishFromMenuService,
    editDishInMenuService
}