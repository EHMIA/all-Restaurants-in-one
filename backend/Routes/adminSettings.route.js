import {Router} from "express"
import { acceptRejectRequest, getOneRequest, getRestaurantRequests, getSystemSettings, updateSysSettings } from "../Controllers/AdminSettings.controller.js";
import { Protect, restrictToAdmin } from "../Middlewares/auth.middleware.js";
const router=Router();


router.get("/settings",Protect,restrictToAdmin,getSystemSettings);

router.put("/settings",Protect,restrictToAdmin,updateSysSettings);

router.get("/requests",Protect,restrictToAdmin,getRestaurantRequests);

router.get("requests/:restaurantId",Protect,restrictToAdmin,getOneRequest);

router.post("/requests/:restaurantId/:decision",Protect,restrictToAdmin,acceptRejectRequest);

export default router;