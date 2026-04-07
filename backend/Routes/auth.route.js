import {Router} from "express"
const router=Router();

import { login } from "../Controllers/login.js";
import { register } from "../Controllers/register.js";
import { forgotPassword } from "../Controllers/forgot_password.js";
import { resetPassword } from "../Controllers/reset_password.js";

router.post('/login', login);
router.post('/register', register);
router.post('/forgot-password', forgotPassword);
router.post('/reset-password', resetPassword);


export default router;