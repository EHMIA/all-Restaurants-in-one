import {Router} from "express"
const router=Router();
import { editUserProfile } from "../Controllers/EditUser.js";


router.post('/editUserProfile', Protect, editUserProfile);


export default router;  