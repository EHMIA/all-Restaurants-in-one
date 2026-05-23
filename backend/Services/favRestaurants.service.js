import { favResModel } from "../Models/FavoriteRestaurants.model.js"
import { CalculateOpenNow } from "../Utils/handleRestaurantData.util.js";

// just users
// get all favs
const getMyFavRestaurantsService= async(userID)=>{
    const favRestauransts= await favResModel.find({user:userID}).
    populate("restaurant","name coverPhoto rating delivery cuisineType priceRange openingHours");

    if (favRestauransts.length === 0) return null; 
    const processedFavorites = favRestauransts.map(fav => {
        
        const favObj = fav.toObject();
        
        if (favObj.restaurant) {
            favObj.restaurant.isOpen = CalculateOpenNow(favObj.restaurant);
            favObj.restaurant.serverTime = new Date().toISOString();
        }

        return favObj;
    });

    return processedFavorites;
}


// add to fav
const addRestaurantToFavService=async(restaurantID,userID)=>{
    const favRestaurant= new favResModel(
        {
            restaurant:restaurantID,
            user:userID
        }
    );

    await favRestaurant.save();
    return favRestaurant;

}

// remove from fav
const removeRestaurantFromFavService=async(restaurantID,userID)=>{
    const favRestaurant= await favResModel.findOneAndDelete({
        user:userID,
        restaurant:restaurantID
    });
    if(!favRestaurant)return null;
    return favRestaurant;
}

export{
    getMyFavRestaurantsService,
    addRestaurantToFavService,
    removeRestaurantFromFavService
}


