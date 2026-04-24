import {Router} from "express"
const router=Router();

import { login, register , forgotPassword , resetPassword , verifyOTP} from "../Controllers/auth.controller.js";

router.post('/login', login);
router.post('/register', register);
router.post('/forgot-password', forgotPassword);
router.post('/verify-otp', verifyOTP);
router.patch('/reset-password', resetPassword);

export default router;