import {Router} from "express"
const router=Router();
import { getUserProfile , uploadProfilePicController , editUserProfile , deleteAccountController , deleteProfilePicController , changePasswordController} from "../Controllers/user.controller.js";
import { Protect } from "../Middlewares/auth.middleware.js";
import { restrictToAdminOrAccountOwner } from "../Middlewares/auth.middleware.js";
import { uploadSingleImage } from "../Middlewares/upload.middleware.js";
import { getMyRestaurantDashboard } from "../Controllers/restaurant.controller.js";


router.get('/getUserProfile', Protect, getUserProfile);
router.patch('/editUserProfile/:id', Protect, restrictToAdminOrAccountOwner, editUserProfile);
router.patch('/uploadProfilePhoto', Protect, uploadSingleImage, uploadProfilePicController);
router.delete('/deleteProfilePhoto/:id', Protect, restrictToAdminOrAccountOwner, deleteProfilePicController);
router.patch('/changePassword', Protect,changePasswordController);
router.delete('/deleteAccount/:id', Protect, restrictToAdminOrAccountOwner, deleteAccountController);



// For Owner DashBoard
router.get("/my/dashboard",Protect,getMyRestaurantDashboard);


export default router;  