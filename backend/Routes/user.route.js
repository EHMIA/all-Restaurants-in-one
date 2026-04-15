import {Router} from "express"
const router=Router();
import { getUserProfile } from "../Controllers/GetUserProfile.js";
import { uploadProfilePicController } from "../Controllers/UploadPhoto.js";
import { Protect } from "../Middlewares/auth.middleware.js";
import { restrictToAdminOrAccountOwner } from "../Middlewares/auth.middleware.js";
import { uploadSingleImage } from "../Middlewares/upload.middleware.js";
import { editUserProfile } from "../Controllers/EditUser.js";

router.get('/getUserProfile', Protect, getUserProfile);
router.post('/uploadPhoto', Protect, uploadSingleImage, uploadProfilePicController);
router.post('/editUserProfile/:id', Protect, restrictToAdminOrAccountOwner, editUserProfile);




export default router;  