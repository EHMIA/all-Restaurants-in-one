import asyncHandler from "express-async-handler"
import { getOneRestaurantService } from "../Services/restaurant.service.js"
import { addRestaurantToFavService, getMyFavRestaurantsService, removeRestaurantFromFavService } from "../Services/favRestaurants.service.js"
import { favResModel } from "../Models/FavoriteRestaurants.model.js";

// account_owner
const getMyFavRestaurants=asyncHandler(async(req,res)=>{
    const restaurants= await getMyFavRestaurantsService(req.user.id);
    if(!restaurants)
        return res.status(404).json({message:"No favorite Restaurants Found"});
    res.status(200).json(restaurants);
});



const addRestaurantToFav=asyncHandler(async(req,res)=>{
    const restaurantId=req.params.id;
    const userId=req.user.id;
    const restaurant=await getOneRestaurantService(restaurantId);
    if(!restaurant)
        return res.status(404).json({message:"No such Restaurant Found"});
    
    const FavRestaurant= await favResModel.findOne({
        user:userId,
        restaurant:restaurant._id
    });
    if(FavRestaurant)
        return res.status(400).json({message:"Restaurant already in your favorites"});
    
    const newFavRestaurant=await addRestaurantToFavService(restaurantId,userId);
    
    res.status(200).json({
        message:"Restaurant added to favorites successfully",
        favoriteRestaurant:newFavRestaurant
    });
})

const removeRestaurantFromFav=asyncHandler(async(req,res)=>{
    const restaurantId=req.params.id;
    const userId=req.user.id;
    const restaurant=await getOneRestaurantService(restaurantId);
    if(!restaurant)
        return res.status(404).json({message:"No such Restaurant Found"});
    
    const FavRestaurant= await favResModel.findOne({
        user:userId,
        restaurant:restaurant._id
    });
    if(!FavRestaurant)
        return res.status(400).json({message:"Restaurant not in your favorites"});
    
    const deletedFavRestaurant=await removeRestaurantFromFavService(restaurantId,userId);
    res.status(200).json(deletedFavRestaurant);
})
export{
    getMyFavRestaurants,
    addRestaurantToFav,
    removeRestaurantFromFav
}