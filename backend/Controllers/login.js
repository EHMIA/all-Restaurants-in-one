const router = express.Router();
// import dotenv from 'dotenv'; 
// const User = require('../Models/user.model');
// dotenv.config();

import { compare } from 'bcrypt';
import { sign } from 'jsonwebtoken';
import { findOne, Users } from '../Models/user.model';
import { loginSchema } from '../Validators/login_validation';

const login = async (req, res) => {
    try {

        const { error } = loginSchema.validate(req.body);
        if (error) {
            return res.status(400).json({ error: error.details[0].message });
        }

        let { email, password } = req.body;


        const user = await findOne({ email });
        if (!user) {
            return res.status(400).json({ error: 'Invalid email or password' });
        }


        const isMatch = await compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ error: 'Invalid email or password' });
        }


        const token = user.generateToken();


        const userWithoutPassword = {
            id: user._id,
            fullname: user.fullname,
            email: user.email,
            phone: user.phone
        };

        res.status(200).json({
            message: 'Login successfully',
            token,
            user: userWithoutPassword
        });

    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server login error' });
    }
};

export
 { login };