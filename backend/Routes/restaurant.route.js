import { Router } from "express";
import { restrictToAdminOrUser } from "../Middlewares/auth.middleware";
import { createNewRestaurant } from "../Controllers/restaurant.controller";
const router = Router();

// create restaurant
router.post("/create",restrictToAdminOrUser,createNewRestaurant());

