import { Router } from "express";
import { deleteAllMsg, deleteOneMsg, getMyNotifications, getOneNotification } from "../Controllers/notifications.controller.js";
import { Protect, restrictToAccountOwner } from "../Middlewares/auth.middleware.js";
const router= Router();

router.get("/",Protect,restrictToAccountOwner,getMyNotifications);
router.get("/:id",Protect,restrictToAccountOwner,getOneNotification);

export default router;