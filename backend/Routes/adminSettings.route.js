import {Router} from "express"
import { getSystemSettings, updateSysSettings } from "../Controllers/AdminSettings.controller.js";
import { Protect, restrictToAdmin } from "../Middlewares/auth.middleware.js";
const router=Router();


router.get("/settings",Protect,restrictToAdmin,getSystemSettings);

router.put("/settings",Protect,restrictToAdmin,updateSysSettings);


export default router;