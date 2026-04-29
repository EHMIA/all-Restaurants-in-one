import {Router} from "express"
const router=Router();
import { refreshTokenHandler } from "../Controllers/Refrsh.controller.js";

router.get('/', refreshTokenHandler);

export default router;