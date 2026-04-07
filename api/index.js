import { ConnectDB } from "../backend/Config/Connectdb.js";
import { configDotenv } from "dotenv";
import express, { json } from "express";
import authRoutes from "../backend/Routes/auth.route.js";
import RestaurantsRoutes from "../backend/Routes/restaurant.route.js";
import { errorHandler, notFoundHandler } from "../backend/Middlewares/notFoundErrorHandler.middleware.js";


configDotenv();
const app = express();


ConnectDB();

// Middlewares
app.use(json());

// Routes
app.use("/auth", authRoutes);
app.use("/restaurants", RestaurantsRoutes);

// temporary route for check back response on vercel
app.get("/", (req, res) => {
    res.status(200).json({ message: "API is running smoothly on Vercel" });
});

// Error Handling Middlewares
app.use(notFoundHandler);
app.use(errorHandler);

//export app to use on vercel
export default app;