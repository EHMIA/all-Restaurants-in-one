import express from 'express';
import { compare } from 'bcrypt';
import { Users } from '../Models/user.model.js';
import { loginSchema } from '../Validators/login_validation.js';
import { hash } from "bcrypt";
import { registerSchema } from "../Validators/register_validation.js";
import asyncHandler from "express-async-handler";
import { createTransport } from 'nodemailer';
import jwt from 'jsonwebtoken';
import { configDotenv } from "dotenv";
configDotenv();
// import { config } from 'dotenv'; 
// config();


const register = asyncHandler(async (req, res) => {
    const { error } = registerSchema.validate(req.body);

    if (error) return res.status(400).json({ error: error.details[0].message });

        const { fullname, email, phone, password } = req.body;


    const existingUser = await Users.findOne({ email });
    if (existingUser)
        return res.status(400).json({ error: "User already exists" });

    const hashedPassword = await hash(password, 10);

    const newUser = new Users({
        fullname,
        email,
        phone,
        password: hashedPassword,
    });

    await newUser.save();
    const token = newUser.generateToken();
    const refreshToken = newUser.generateRefreshToken();

    // إرسال الـ Refresh Token كـ Cookie آمنة
    res.cookie('jwt', refreshToken, {
        httpOnly: true, // بيمنع الـ XSS attacks
        secure: process.env.NODE_ENV === 'production', // بيشتغل على https بس لو في البرودكشن
        sameSite: 'None',
        maxAge: 7 * 24 * 60 * 60 * 1000 // 7 أيام
    });

    
    const { password: _password, ...userWithoutPassword } = newUser.toObject();

    res.status(201).json({
        Token: token,
        user: {...userWithoutPassword, role: newUser.role },
    });
});


                  //======================================================//


const login = async (req, res) => {
    try {

        const { error } = loginSchema.validate(req.body);
        if (error) {
            return res.status(400).json({ error: error.details[0].message });
        }

        let { email, password } = req.body;


        const user = await Users.findOne({ email });
        if (!user) {
            return res.status(400).json({ error: 'Invalid email or password' });
        }


        const isMatch = await compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ error: 'Invalid email or password' });
        }


        const token = user.generateToken();
        const refreshToken = user.generateRefreshToken();

        // إرسال الـ Refresh Token كـ Cookie آمنة
        res.cookie('jwt', refreshToken, {
            httpOnly: true, // بيمنع الـ XSS attacks
            secure: process.env.NODE_ENV === 'production', // بيشتغل على https بس لو في البرودكشن
            sameSite: 'None',
            maxAge: 7 * 24 * 60 * 60 * 1000 // 7 أيام
        });


        const userWithoutPassword = {
            id: user._id,
            fullname: user.fullname,
            email: user.email,
            phone: user.phone
        };

        res.status(200).json({
            message: 'Login successfully',
            Token: token,
            user:{...userWithoutPassword, role: user.role },
        });

    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server login error' });
    }
};



                  //======================================================//



const transporter = createTransport({
    service: 'Gmail',
    auth: { 
        user: process.env.EMAIL,
        pass: process.env.EMAIL_PASSWORD
    },
    tls: {
        rejectUnauthorized: false
    }
});

function generateOTP() {
    return Math.floor(100000 + Math.random() * 900000).toString();
}

// const forgotPassword = async (req, res) => {
//     try {
//         const { email } = req.body;

//         if (!email) {
//             return res.status(400).json({ message: 'Email is required' });
//         }

//         const user = await Users.findOne({ email });
//         if (!user) {
//             return res.status(400).json({ message: 'User not found' });
//         }

//         const otp = generateOTP();

//         user.otp = otp;
//         user.otpExpire = Date.now() + 10 * 60 * 1000; 
//         await user.save();

//         await transporter.sendMail({
//             from: process.env.EMAIL,
//             to: email,
//             subject: 'Reset Password OTP',
//             text: `Your OTP code is ${otp}`,
//         });

//         res.status(200).json({ message: 'OTP sent to email', otp , email , userId: user._id});

//     } catch (error) {
//         res.status(500).json({ message: 'Error server sending OTP', error });
//     }
// };


const forgotPassword = asyncHandler (async (req, res) => {
    
        const { email } = req.body;
        
        if (!email) {
            return res.status(400).json({ message: 'Email is required' });
        }

        const user = await Users.findOne({ email });
        if (!user) {
            return res.status(400).json({ message: 'User not found' });
        }

        const otp = generateOTP();
        
        user.otp = otp;
        user.otpExpire = Date.now() + 10 * 60 * 1000; // صالح لمدة 10 دقائق
        await user.save();

        await transporter.sendMail({
            from: process.env.EMAIL,
            to: email,
            subject: 'Reset Password OTP',
            text: `Your OTP code is ${otp}`,
        });

        const verificationToken = jwt.sign(
            { 
                id: user._id,
                purpose: 'OTP_VERIFICATION' 
            }, 
            process.env.JWT_SECRET, 
            { expiresIn: '10m' }
        );

        res.status(200).json({ 
            message: 'OTP sent to email successfully',
            otp : otp,
            verificationToken : verificationToken
        });
});


                  //======================================================//


const verifyOTP = asyncHandler(async (req, res) => {

    const authHeader = req.headers.authorization;
    const { otp } = req.body;

    if (!authHeader) {
        return res.status(400).json({ message: 'Token and are required' });

    }

    if (!otp) {
        return res.status(400).json({ message: 'OTP are required' });
    }

    if (authHeader && !authHeader.startsWith("Bearer ")) {
        return res.status(401).json({ message: "Invalid token format" });
    }

    const token = authHeader.split(" ")[1];

    let decoded;
    try {
        decoded = jwt.verify(token, process.env.JWT_SECRET);

        if (decoded.purpose !== 'OTP_VERIFICATION') {
            return res.status(403).json({ message: 'Invalid token purpose' });
        }
    } catch (err) {
        return res.status(401).json({ message: 'Session expired, Invalid or expired token , please request a new OTP' });
    }

    const user = await Users.findById(decoded.id);
    if (!user) return res.status(400).json({ message: 'User not found' });

    if (user.otp !== otp) return res.status(400).json({ message: 'Invalid OTP' });
    if (user.otpExpire < Date.now()) return res.status(400).json({ message: 'OTP expired' });

    const resetToken = jwt.sign(
        {
            id: user._id,
            purpose: 'PASSWORD_RESET'
        },
        process.env.JWT_SECRET,
        { expiresIn: '15m' }
    );

    user.otp = null;
    user.otpExpire = null;
    await user.save();

    res.status(200).json({
        message: 'OTP verified successfully',
        resetToken: resetToken
    });
});


                  //======================================================//




// const resetPassword = async (req, res) => {
//         try {
//             const { email, otp, password, confirmPassword } = req.body;

//             if (!email || !otp || !password || !confirmPassword) {
//                 return res.status(400).json({ message: 'All fields are required' });
//             }

//             const user = await Users.findOne({ email });
//             if (!user) {
//                 return res.status(400).json({ message: 'User not found' });
//             }

//             if (password !== confirmPassword) {
//                 return res.status(400).json({ message: 'Passwords do not match' });
//             }

//             if (user.otp !== otp) {
//                 return res.status(400).json({ message: 'Invalid OTP' });
//             }


//             if (user.otpExpire < Date.now()) {
//                 return res.status(400).json({ message: 'OTP expired' });
//             }


//             const hashedPassword = await hash(password, 10);

//             user.password = hashedPassword;
//             user.otp = null;
//             user.otpExpire = null;

//             await user.save();

//             res.status(200).json({ message: 'Password reset successful' });

//         } catch (error) {
//             res.status(500).json({ message: 'Error resetting password', error });
//         }
//     };
const resetPassword = asyncHandler(async (req, res) => {

    const { password, confirmPassword } = req.body;
    const authHeader = req.headers.authorization;

    if (!authHeader) {
        return res.status(400).json({ message: 'Token is required' });

    }

    if (authHeader && !authHeader.startsWith("Bearer ")) {
        return res.status(401).json({ message: "Invalid token format" });
    }


    if (!password || !confirmPassword) {
        return res.status(400).json({ message: 'All fields are required' });
    }

    if (password !== confirmPassword) {
        return res.status(400).json({ message: 'Passwords do not match' });
    }

    const token = authHeader.split(" ")[1];
    let decoded;
    try {
        decoded = jwt.verify(token, process.env.JWT_SECRET);

        if (decoded.purpose !== 'PASSWORD_RESET') {
            return res.status(403).json({ message: 'Unauthorized: This token cannot be used to reset password' });
        }
    } catch (err) {
        return res.status(401).json({ message: 'Invalid or expired reset token' });
    }

    const user = await Users.findById(decoded.id);
    if (!user) return res.status(400).json({ message: 'User not found' });

    const hashedPassword = await hash(password, 10);
    user.password = hashedPassword;

    await user.save();

    res.status(200).json({ message: 'Password reset successful' });


});


export { login, register, forgotPassword, resetPassword , verifyOTP };