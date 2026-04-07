    import express from 'express';
    import { hash } from 'bcrypt';
    import { Users } from "../Models/user.model.js";


    const resetPassword = async (req, res) => {
        try {
            const { email, otp, password, confirmPassword } = req.body;

            if (!email || !otp || !password || !confirmPassword) {
                return res.status(400).json({ message: 'All fields are required' });
            }

            const user = await Users.findOne({ email });
            if (!user) {
                return res.status(400).json({ message: 'User not found' });
            }

            if (password !== confirmPassword) {
                return res.status(400).json({ message: 'Passwords do not match' });
            }

            if (user.otp !== otp) {
                return res.status(400).json({ message: 'Invalid OTP' });
            }


            if (user.otpExpire < Date.now()) {
                return res.status(400).json({ message: 'OTP expired' });
            }


            const hashedPassword = await hash(password, 10);

            user.password = hashedPassword;
            user.otp = null;
            user.otpExpire = null;

            await user.save();

            res.status(200).json({ message: 'Password reset successful' });

        } catch (error) {
            res.status(500).json({ message: 'Error resetting password', error });
        }
    };

    export  { resetPassword };