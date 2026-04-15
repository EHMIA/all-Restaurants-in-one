import {Router} from "express"
import { addReview, getMyReviews } from "../Controllers/reviews.controller.js";
import { Protect, restrictToAccountOwner } from "../Middlewares/auth.middleware.js";

const router= Router();


router.get("/my-reviews",Protect,restrictToAccountOwner ,getMyReviews);

router.post("/add-review",Protect,restrictToAccountOwner, addReview);

export default router;