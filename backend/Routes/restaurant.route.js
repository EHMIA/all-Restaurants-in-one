import { Router } from "express";
import { createNewRestaurant, getAllRestaurants, getOneRestaurant, getSelectionRestaurant } from "../Controllers/restaurant.controller.js";
import { uploadRestaurantData } from "../Middlewares/upload.middleware.js";
import { Protect, restrictToAdminOrAccountOwner } from "../Middlewares/auth.middleware.js";
const router = Router();

router.get("/",getAllRestaurants);

router.get("/:id",getOneRestaurant);

router.get('/:id/details', getSelectionRestaurant);

router.post("/",Protect,uploadRestaurantData,createNewRestaurant)
        

export default router;





