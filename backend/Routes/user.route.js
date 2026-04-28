import {Router} from "express"
const router=Router();
import { getUserProfile , uploadProfilePicController , editUserProfile , deleteAccountController , deleteProfilePicController} from "../Controllers/user.controller.js";
import { Protect } from "../Middlewares/auth.middleware.js";
import { restrictToAdminOrAccountOwner } from "../Middlewares/auth.middleware.js";
import { uploadSingleImage } from "../Middlewares/upload.middleware.js";
import { getMyRestaurantDashboard } from "../Controllers/restaurant.controller.js";


router.get('/getUserProfile', Protect, getUserProfile);
router.post('/uploadPhoto', Protect, uploadSingleImage, uploadProfilePicController);
router.post('/editUserProfile/:id', Protect, restrictToAdminOrAccountOwner, editUserProfile);
router.delete('/deleteUserProfile/:id', Protect, restrictToAdminOrAccountOwner, deleteProfilePicController);


// For Owner DashBoard
router.get("/my/dashboard",Protect,getMyRestaurantDashboard);


export default router;  