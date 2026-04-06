import { ConnectDB } from "./Config/Connectdb.js"
import {configDotenv} from "dotenv"
import express, { json } from "express"
import mongoose from "mongoose"
import authRoutes from "./Routes/auth.route.js"
const app=express();

app.use(json());
app.use("auth/", authRoutes);
configDotenv();
ConnectDB();


// const PORT = process.env.PORT || 3000;
// app.listen(PORT, () => console.log(`Server on port ${PORT}`));

mongoose.connection.once('open', () => {
    console.log('Connected to MongoDB successfully! ');
    
    const PORT = process.env.PORT || 3000;
    app.listen(PORT, () => {
        console.log(`Server is running on port ${PORT} `);
    });
});

mongoose.connection.on('error', (err) => {
    console.error(`MongoDB connection error: ${err} `);
});