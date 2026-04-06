const express = require('express');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const dotenv = require('dotenv'); 
const User = require('../Models/user.model');
const { registerSchema } = require('../Validators/register_validation');
dotenv.config();

const register = async (req, res) => {  
    try {
        const { error } = registerSchema.validate(req.body);            

        if (error) {
            return res.status(400).json({ error: error.details[0].message });
        }               
        let {fullname, phone , email, password } = req.body;


        fullname = fullname.trim();
        phone = phone.trim();
        email = email.trim();

        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ error: 'Email already exists' });
        }       
        const hashedPassword = await bcrypt.hash(password, 10);

        const newUser = new User({
            fullname,
            email,
            phone,
            password: hashedPassword
        });
        await newUser.save();
        const token = jwt.sign(
            { id: newUser._id },
            process.env.JWT_SECRET,
            { expiresIn: '1h' }
        );

        res.status(201).json({
            message: 'User registered successfully',
            token,
            user: newUser
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server registration error' });
    }   
};

module.exports = { register };