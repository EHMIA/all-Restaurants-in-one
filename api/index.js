import { configDotenv } from "dotenv";
configDotenv();
import redisOptions from "../backend/Config/redis.config.js";

import express, { json } from "express";
import cors from "cors";

import { ConnectDB } from "../backend/Config/Connectdb.js";
import authRoutes from "../backend/Routes/auth.route.js";
import userRoutes from "../backend/Routes/user.route.js";
import RestaurantsRoutes from "../backend/Routes/restaurant.route.js";
import { errorHandler, notFoundHandler } from "../backend/Middlewares/notFoundErrorHandler.middleware.js";
import SettingsRoutes from "../backend/Routes/adminSettings.route.js";   
import favRestaurantsRoutes from "../backend/Routes/favRestaurants.route.js";
import ReviewsRoutes from "../backend/Routes/reviews.route.js";
import restaurantDataRoutes from "../backend/Routes/restaurantData.route.js";

const app = express();
app.use(cors());
app.use(json());

await ConnectDB();


// temporary route for check back response on vercel
app.get("/", (req, res) => {
    res.status(200).json({ message: "API is running smoothly on Vercel" });
});


// Routes
app.use("/auth", authRoutes);
app.use("/user", userRoutes);
app.use("/restaurants", RestaurantsRoutes);
app.use("/admin", SettingsRoutes);
app.use("/favorites", favRestaurantsRoutes);
app.use("/reviews",ReviewsRoutes);
app.use("/restaurant-data",restaurantDataRoutes);   

app.use(notFoundHandler);
app.use(errorHandler);


const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`Server is running locally on http://localhost:${PORT}`);
});
export default app;
