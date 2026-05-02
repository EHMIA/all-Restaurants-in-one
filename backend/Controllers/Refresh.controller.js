import jwt from 'jsonwebtoken';
import {Users} from '../Models/user.model.js';
import asyncHandler from "express-async-handler";
import { configDotenv } from "dotenv";
configDotenv();

// Route: GET /api/refresh
const refreshTokenHandler = asyncHandler(async (req, res) => {
    // هنجيب الـ Refresh Token من الكوكيز
    const cookies = req.cookies;
    if (!cookies?.jwt) return res.status(401).json({ message: 'Unauthorized' });

    const refreshToken = cookies.jwt;

    jwt.verify(refreshToken , process.env.REFRESH_TOKEN_SECRET , async (err, decoded) => {

            if (err) return res.status(403).json({ message: 'Forbidden' });

            const user = await Users.findById(decoded.id);
            if (!user) return res.status(401).json({ message: 'Unauthorized' });

            
            const token = user.generateToken();

            res.json({ accessToken: token });
        }
    );
});

export { refreshTokenHandler };