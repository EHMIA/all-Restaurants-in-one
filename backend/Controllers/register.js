import express from 'express';
import { hash } from 'bcrypt';
import { sign } from 'jsonwebtoken';
import { config } from 'dotenv'; 
import User, { findOne } from '../Models/user.model';
import { registerSchema } from '../Validators/register_validation';
config();

const register = async (req, res) => {  
    try {
        const { error } = registerSchema.validate(req.body);            

        if (error) {
            return res.status(400).json({ error: error.details[0].message });
        }               
        let {fullname, phone , email, password } = req.body;

        const existingUser = await findOne({ email });
        if (existingUser) {
            return res.status(400).json({ error: 'Email already exists' });
        }       
        const hashedPassword = await hash(password, 10);

        const newUser = new User({
            fullname,
            email,
            phone,
            password: hashedPassword
        });
        await newUser.save();
        const token = sign(
            { id: newUser._id ,
              role : newUser.role
             },
            process.env.JWT_SECRET,
            { expiresIn: '1h' }
        );

         const userWithoutPassword = {
            id: newUser._id,
            fullname: newUser.fullname,
            email: newUser.email,
            phone: newUser.phone
        };

        res.status(201).json({
            message: 'User registered successfully',
            token,
            user: userWithoutPassword
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server registration error' });
    }   
};

export  { register };