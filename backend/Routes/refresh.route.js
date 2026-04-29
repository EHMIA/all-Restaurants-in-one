import {Router} from "express"
const router=Router();
import { refreshTokenHandler } from "../Controllers/Refrsh.controller.js";

router.get('/refresh', refreshTokenHandler);

export default router;