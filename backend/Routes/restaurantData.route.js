import {Router} from "express"
import {  uploadMultipleImages, uploadSingleImage } from "../Middlewares/upload.middleware.js";
import { addDishsToMenu, addPhotosToGallery, deleteCoverImage, deleteDishFromMenu, deletePhotoFromGallery, editDishInMenu, getOneDishFromMenu, uploadOrUpdateCoverImage } from "../Controllers/restaurantDetails.controller.js";
import { isApprovedOwner, Protect, restrictToRestaurantOwner } from "../Middlewares/auth.middleware.js";
import { deleteDishFromMenuService } from "../Services/restaurantDetails.service.js";
import { editRestaurantMainData } from "../Controllers/restaurant.controller.js";

const router= Router();

// cover Image
router.post("/coverImage/:restaurantId",Protect,restrictToRestaurantOwner,uploadSingleImage,uploadOrUpdateCoverImage)

router.delete("/coverImage/:restaurantId",Protect,restrictToRestaurantOwner,deleteCoverImage)

// Menu
router.post("/menu/:restaurantId",Protect,restrictToRestaurantOwner,isApprovedOwner,uploadMultipleImages,addDishsToMenu);

router.delete("/menu/:restaurantId/:dishId",Protect,restrictToRestaurantOwner,isApprovedOwner,deleteDishFromMenu);

router.put("/menu/:restaurantId/:dishId",Protect,restrictToRestaurantOwner,isApprovedOwner,uploadSingleImage,editDishInMenu);

router.get("/menu/:restaurantId/:dishId",getOneDishFromMenu);

// gallery
router.post("/gallery/:restaurantId",Protect,restrictToRestaurantOwner,isApprovedOwner,uploadMultipleImages,addPhotosToGallery);

router.delete("/gallery/:restaurantId/:imgId",Protect,restrictToRestaurantOwner,isApprovedOwner,deletePhotoFromGallery);


//main data
router.put("/main-data/:restaurantId",Protect,restrictToRestaurantOwner,editRestaurantMainData);

export default router;