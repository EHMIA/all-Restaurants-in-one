import {Router} from "express"
const router=Router();
import { getUserProfile , uploadProfilePicController , editUserProfile , deleteAccountController , deleteProfilePicController , changePasswordController} from "../Controllers/user.controller.js";
import { Protect } from "../Middlewares/auth.middleware.js";
import { restrictToAdminOrAccountOwner } from "../Middlewares/auth.middleware.js";
import { uploadSingleImage } from "../Middlewares/upload.middleware.js";


router.get('/getUserProfile', Protect, getUserProfile);
router.post('/uploadPhoto', Protect, uploadSingleImage, uploadProfilePicController);
router.post('/editUserProfile/:id', Protect, restrictToAdminOrAccountOwner, editUserProfile);
router.patch('/changePassword', Protect, restrictToAdminOrAccountOwner, changePasswordController);
router.delete('/deleteAccount/:id', Protect, restrictToAdminOrAccountOwner, deleteAccountController);
router.delete('/deleteUserProfile/:id', Protect, restrictToAdminOrAccountOwner, deleteProfilePicController);


export default router;  