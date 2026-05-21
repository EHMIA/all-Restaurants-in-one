import { Router } from "express";
import { createNewRestaurant, deleteRestaurant, getAllRestaurants, getOneRestaurant, getSelectionRestaurant } from "../Controllers/restaurant.controller.js";
import {  uploadSingleImage } from "../Middlewares/upload.middleware.js";
import { optionalProtect, Protect, restrictToAccountOwner, restrictToRestaurantOwner, restrictToRestaurantOwnerPublic  } from "../Middlewares/auth.middleware.js";
const router = Router();

router.get("/",optionalProtect,getAllRestaurants);
router.get("/:restaurantId",optionalProtect,getOneRestaurant);

router.get('/:restaurantId/details',optionalProtect, getSelectionRestaurant);

router.post("/",Protect,restrictToAccountOwner,uploadSingleImage,createNewRestaurant)

router.delete("/:restaurantId",Protect,restrictToRestaurantOwnerPublic,deleteRestaurant);

export default router;





