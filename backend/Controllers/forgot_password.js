const dotenv = require('dotenv'); 
const User = require('../Models/user.model');
const nodemailer = require('nodemailer');
dotenv.config();

const transporter = nodemailer.createTransport({
    service: 'Gmail',
    auth: { 
        user: process.env.EMAIL,
        pass: process.env.EMAIL_PASSWORD
    }
});

function generateOTP() {
    return Math.floor(100000 + Math.random() * 900000).toString();
}

const forgotPassword = async (req, res) => {
    try {
        const { email } = req.body;

        if (!email) {
            return res.status(400).json({ message: 'Email is required' });
        }

        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ message: 'User not found' });
        }

        const otp = generateOTP();

        user.otp = otp;
        user.otpExpire = Date.now() + 10 * 60 * 1000; 
        await user.save();

        await transporter.sendMail({
            from: process.env.EMAIL,
            to: email,
            subject: 'Reset Password OTP',
            text: `Your OTP code is ${otp}`,
        });

        res.status(200).json({ message: 'OTP sent to email' });

    } catch (error) {
        res.status(500).json({ message: 'Error server sending OTP', error });
    }
};

module.exports = { forgotPassword };
