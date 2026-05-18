import { Router } from "express";
import { Protect, restrictToAccountOwner, restrictToRestaurantOwnerPublic } from "../Middlewares/auth.middleware.js";
import { addRestaurantToFav, getMyFavRestaurants, removeRestaurantFromFav } from "../Controllers/favRestaurants.controller.js";
const router=Router();

// get my fav restaurants
router.get("/",Protect,restrictToRestaurantOwnerPublic,restrictToAccountOwner,getMyFavRestaurants);

// add restaurant to favorites
router.post("/:restaurantId",Protect,restrictToRestaurantOwnerPublic,restrictToAccountOwner,addRestaurantToFav);

// remove restaurant from fav
router.delete("/:restaurantId",Protect,restrictToRestaurantOwnerPublic,restrictToAccountOwner,removeRestaurantFromFav);


export default router;