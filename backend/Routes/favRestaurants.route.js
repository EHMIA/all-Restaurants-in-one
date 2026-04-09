import { Router } from "express";
import { Protect, restrictToAccountOwner } from "../Middlewares/auth.middleware.js";
import { addRestaurantToFav, getMyFavRestaurants, removeRestaurantFromFav } from "../Controllers/favRestaurants.controller.js";
const router=Router();

// get my fav restaurants
router.get("/",Protect,restrictToAccountOwner,getMyFavRestaurants);


// add restaurant to favorites
router.get("/:id",Protect,restrictToAccountOwner,addRestaurantToFav);

// remove restaurant from fav
router.delete("/:id",Protect,restrictToAccountOwner,removeRestaurantFromFav);



export default router;