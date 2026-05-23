import {Router} from "express"
const router=Router();
import { contactUs } from "../Controllers/ContactUs.controller.js";

router.post('/', contactUs);

export default router;