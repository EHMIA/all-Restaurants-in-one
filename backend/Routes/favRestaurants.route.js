import { Router } from "express";
import { Protect, restrictToAccountOwner, restrictToRestaurantOwnerPublic } from "../Middlewares/auth.middleware.js";
import { addRestaurantToFav, getMyFavRestaurants, removeRestaurantFromFav } from "../Controllers/favRestaurants.controller.js";
const router=Router();

// get my fav restaurants
router.get("/",Protect,restrictToAccountOwner,getMyFavRestaurants);

// add restaurant to favorites
router.post("/:restaurantId",Protect,restrictToAccountOwner,addRestaurantToFav);

// remove restaurant from fav
router.delete("/:restaurantId",Protect,restrictToAccountOwner,removeRestaurantFromFav);


export default router;