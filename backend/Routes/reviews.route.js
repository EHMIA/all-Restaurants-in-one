import {Router} from "express"
import { addReview, deleteReview, getMyReviews, getOneReview } from "../Controllers/reviews.controller.js";

import { Protect, restrictToAccountOwner } from "../Middlewares/auth.middleware.js";

const router= Router();


router.get("/my-reviews",Protect,restrictToAccountOwner ,getMyReviews);

router.get("/review/:restaurantId",Protect,restrictToAccountOwner,getOneReview);


router.post("/add-review/:restaurantId",Protect,restrictToAccountOwner, addReview);

router.delete("/delete-review/:restaurantId",Protect,restrictToAccountOwner, deleteReview);

export default router;