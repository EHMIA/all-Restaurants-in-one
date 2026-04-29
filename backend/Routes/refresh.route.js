import {Router} from "express"
const router=Router();
import { refreshTokenHandler } from "../Controllers/Refresh.controller.js";

router.get('/', refreshTokenHandler);

export default router;