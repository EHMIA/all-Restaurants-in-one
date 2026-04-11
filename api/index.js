import { ConnectDB } from "../backend/Config/Connectdb.js";
import { configDotenv } from "dotenv";
import express, { json } from "express";
import authRoutes from "../backend/Routes/auth.route.js";
import userRoutes from "../backend/Routes/user.route.js";
import RestaurantsRoutes from "../backend/Routes/restaurant.route.js";
import { errorHandler, notFoundHandler } from "../backend/Middlewares/notFoundErrorHandler.middleware.js";
import SettingsRoutes from "../backend/Routes/adminSettings.route.js";   
import favRestaurantsRoutes from "../backend/Routes/favRestaurants.route.js";

import cors from "cors";


configDotenv();
const app = express();

app.use(cors());

ConnectDB();

// Middlewares
app.use(json());

// Routes
app.use("/auth", authRoutes);
app.use("/user", userRoutes);
app.use("/restaurants", RestaurantsRoutes);
app.use("/admin", SettingsRoutes);
app.use("/favorites", favRestaurantsRoutes);

app.use(notFoundHandler);
app.use(errorHandler);

// temporary route for check back response on vercel
app.get("/", (req, res) => {
    res.status(200).json({ message: "API is running smoothly on Vercel" });
});

// Error Handling Middlewares



const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
    console.log(`Server is running locally on http://localhost:${PORT}`);
});

export default app;

// //export app to use on vercel
// export default app;