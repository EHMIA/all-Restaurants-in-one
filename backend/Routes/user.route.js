import {Router} from "express"
const router=Router();
import { getUserProfile } from "../Controllers/GetUserProfile.js";
import { Protect } from "../Middlewares/auth.middleware.js";


router.post('/getUserProfile', Protect, getUserProfile);



export default router;  