import asyncHandler from "express-async-handler";
import { addDishsToMenuService, deleteCoverImageService, deleteDishFromMenuService, editDishInMenuService,  uploadOrUpdateCoverImageService } from "../Services/restaurantDetails.service.js";
import { getOneRestaurantService } from "../Services/restaurant.service.js";
import { addDishsToMenuValidation, editDishInMenuValidation } from "../Validators/restaurant.validator.js";

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

const addDishsToMenu= asyncHandler(async(req,res)=>{
    const restaurant= req.restaurant;
    const files= req.files;

    if(req.body.menu)
        req.body.menu= JSON.parse(req.body.menu);

    console.log(req.body.menu);
    const {error}= addDishsToMenuValidation(req.body);
    if(error)
        return res.status(400).json({message:error.details[0].message});

    if(!files || files.length===0)
        return res.status(400).json({message:"Dish images are required"});

    if(files.length!== req.body.menu.length)
        return res.status(400).json({message:"Each dish should have an image"});
    
    const updatedRestaurant= await addDishsToMenuService(restaurant,req.body.menu,files);
    if(!updatedRestaurant)
        return res.status(500).json({message:"Failed to add dishes to menu"});
    res.status(200).json({
        message:"Dishes added to menu successfully",
        dishes:updatedRestaurant.menu
    });
}) 


const deleteDishFromMenu= asyncHandler(async(req,res)=>{
    const restaurant= req.restaurant;
    const dishId= req.params.dishId;
    if(!dishId)
        return res.status(400).json({message:"Dish ID is required"});

    const deletedDish= await deleteDishFromMenuService(restaurant,dishId);
    if(!deletedDish)
        return res.status(500).json({message:"Failed to delete dish from menu"});
    res.status(200).json({
        message:"Dish deleted from menu successfully"
    });
});


const editDishInMenu= asyncHandler(async(req,res)=>{
    const restaurant= req.restaurant;
    const file= req.file;
    const dishId= req.params.dishId;
    if(!dishId)
        return res.status(400).json({message:"Dish ID is required"});

    const {error}= editDishInMenuValidation(req.body);
    if(error)
        return res.status(400).json({message:error.details[0].message});
    
    const updatedRestaurant= await editDishInMenuService(restaurant,req.body,dishId,file);
    if(!updatedRestaurant)
        return res.status(500).json({message:"Failed to update dish in menu , may be dish not found"});
    res.status(200).json({
        message:"Dish updated in menu successfully"
    });
})

export{
    uploadOrUpdateCoverImage,
    deleteCoverImage,
    addDishsToMenu,
    deleteDishFromMenu,
    editDishInMenu
}