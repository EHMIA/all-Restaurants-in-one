import {Router} from "express"
const router=Router();
import { getUserProfile } from "../Controllers/GetUserProfile.js";
import { uploadPhoto } from "../Controllers/UploadPhoto.js";
import { Protect } from "../Middlewares/auth.middleware.js";
import { uploadSingleImage } from "../Middlewares/upload.middleware.js";
import { editUserProfile } from "../Controllers/EditUser.js";

router.get('/getUserProfile', Protect, getUserProfile);
router.post('/uploadPhoto', Protect, uploadSingleImage, uploadPhoto);
router.post('/editUserProfile', Protect, editUserProfile);



export default router;  