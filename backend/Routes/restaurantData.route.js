import {Router} from "express"
import {  uploadMultipleImages, uploadSingleImage } from "../Middlewares/upload.middleware.js";
import { addDishsToMenu, addPhotosToGallery, deleteCoverImage, deleteDishFromMenu, deletePhotoFromGallery, editDishInMenu, getOneDishFromMenu, uploadOrUpdateCoverImage } from "../Controllers/restaurantDetails.controller.js";
import { isApprovedOwner, Protect, restrictToRestaurantOwner, restrictToRestaurantOwnerPublic } from "../Middlewares/auth.middleware.js";
import { deleteDishFromMenuService } from "../Services/restaurantDetails.service.js";
import { editRestaurantMainData } from "../Controllers/restaurant.controller.js";

const router= Router();

// cover Image
router.post("/coverImage/:restaurantId",Protect,restrictToRestaurantOwnerPublic,restrictToRestaurantOwner,uploadSingleImage,uploadOrUpdateCoverImage)

router.delete("/coverImage/:restaurantId",Protect,restrictToRestaurantOwnerPublic,restrictToRestaurantOwner,deleteCoverImage)

// Menu
router.post("/menu/:restaurantId",Protect,restrictToRestaurantOwnerPublic,restrictToRestaurantOwner,isApprovedOwner,uploadMultipleImages,addDishsToMenu);

router.delete("/menu/:restaurantId/:dishId",Protect,restrictToRestaurantOwnerPublic,restrictToRestaurantOwner,isApprovedOwner,deleteDishFromMenu);

router.put("/menu/:restaurantId/:dishId",Protect,restrictToRestaurantOwnerPublic,restrictToRestaurantOwner,isApprovedOwner,uploadSingleImage,editDishInMenu);

router.get("/menu/:restaurantId/:dishId",getOneDishFromMenu);

// gallery
router.post("/gallery/:restaurantId",Protect,restrictToRestaurantOwnerPublic,restrictToRestaurantOwner,isApprovedOwner,uploadMultipleImages,addPhotosToGallery);

router.delete("/gallery/:restaurantId/:imgId",Protect,restrictToRestaurantOwnerPublic,restrictToRestaurantOwner,isApprovedOwner,deletePhotoFromGallery);


//main data
router.put("/main-data/:restaurantId",Protect,restrictToRestaurantOwnerPublic,restrictToRestaurantOwner,editRestaurantMainData);

export default router;