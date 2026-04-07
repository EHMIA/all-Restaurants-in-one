import { Router } from "express";
import { createNewRestaurant, getAllRestaurants, getOneRestaurant } from "../Controllers/restaurant.controller.js";
import { uploadRestaurantData } from "../Middlewares/upload.middleware.js";
import { Protect, restrictToAdminOrAccountOwner } from "../Middlewares/auth.middleware.js";
const router = Router();

// get all restaurants (pagination) and filtering 
/**
 * @desc get all restaurants
 * @Method GET
 * @access Public 
 * @Route  {
 *         ../restaurants?Page=1&Limit=10&priceRange=low&minRating=5&delivery=yes&cusineType=egyption
 *         ../restaurants/top=5
 *         }
 */
router.get("/",getAllRestaurants);


/**
 * @desc get One restaurant
 * @Method GET
 * @access Public 
 * @Route {
 *        ../restaurant/:restaurantId/photos
 *        ../restaurant/:restaurantId/menu
 *        ../restaurant/:restaurantId/reviews
 *        ../restaurant/:restaurantId  -> main data
 *        ../restaurant/:restaurantId/all  -> all restaurant data
 *        }
 */
router.get("/:id",getOneRestaurant);

/**
 * @desc create restaurant
 * @Method POST
 * @access admin or user => middleware (token)
 * @Route ../restaurants/
 */

router.post("/",Protect,uploadRestaurantData,createNewRestaurant)
            



// edit restaurant 
/**
 * delete , add photo (owner)
 * delete , add , edit menu (owner)
 * edit main data (owner)
 */



export default router;





