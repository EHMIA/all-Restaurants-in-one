import { favResModel } from "../Models/FavoriteRestaurants.model.js"

// just users
// get all favs
const getMyFavRestaurantsService= async(userID)=>{
    const favRestauranst= await favResModel.find({user:userID});
    if(favRestauranst.length===0)return null;
    return favRestauranst;
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


