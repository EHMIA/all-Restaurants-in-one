import {Router} from "express"
import {  uploadMultipleImages, uploadSingleImage } from "../Middlewares/upload.middleware.js";
import { addDishsToMenu, addPhotosToGallery, deleteCoverImage, deleteDishFromMenu, deletePhotoFromGallery, editDishInMenu, uploadOrUpdateCoverImage } from "../Controllers/restaurantDetails.controller.js";
import { Protect, restrictToRestaurantOwner } from "../Middlewares/auth.middleware.js";
import { deleteDishFromMenuService } from "../Services/restaurantDetails.service.js";

const router= Router();

// cover Image
router.post("/coverImage/:id",Protect,restrictToRestaurantOwner,uploadSingleImage,uploadOrUpdateCoverImage)

router.delete("/coverImage/:id",Protect,restrictToRestaurantOwner,deleteCoverImage)

// Menu
router.post("/menu/:id",Protect,restrictToRestaurantOwner,uploadMultipleImages,addDishsToMenu);

router.delete("/menu/:id/:dishId",Protect,restrictToRestaurantOwner,deleteDishFromMenu);

router.put("/menu/:id/:dishId",Protect,restrictToRestaurantOwner,uploadSingleImage,editDishInMenu);


// gallery
router.post("/gallery/:id",Protect,restrictToRestaurantOwner,uploadMultipleImages,addPhotosToGallery);

router.delete("/gallery/:id/:imgId",Protect,restrictToRestaurantOwner,deletePhotoFromGallery);

export default router;