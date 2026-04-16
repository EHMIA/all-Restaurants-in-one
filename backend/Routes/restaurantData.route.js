import {Router} from "express"
import {  uploadSingleImage } from "../Middlewares/upload.middleware.js";
import { deleteCoverImage, uploadOrUpdateCoverImage } from "../Controllers/restaurantDetails.controller.js";
import { Protect, restrictToRestaurantOwner } from "../Middlewares/auth.middleware.js";

const router= Router();

router.post("coverImage/:id",Protect,restrictToRestaurantOwner,uploadSingleImage,uploadOrUpdateCoverImage)

router.delete("coverImage/:id",Protect,restrictToRestaurantOwner,deleteCoverImage)

export default router;