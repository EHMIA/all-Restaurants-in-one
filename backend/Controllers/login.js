const router = express.Router();
// const dotenv = require('dotenv'); 
// const User = require('../Models/user.model');
// dotenv.config();

const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const User = require('../Models/user.model');
const { loginSchema } = require('../Validators/login_validation');

const login = async (req, res) => {
    try {

        const { error } = loginSchema.validate(req.body);
        if (error) {
            return res.status(400).json({ error: error.details[0].message });
        }

        let { email, password } = req.body;

        email = email.trim();

        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ error: 'Invalid email or password' });
        }


        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ error: 'Invalid email or password' });
        }


        const token = jwt.sign(
            { id: user._id },
            process.env.JWT_SECRET,
            { expiresIn: '1h' }
        );


        const userWithoutPassword = {
            id: user._id,
            fullname: user.fullname,
            email: user.email,
            phone: user.phone
        };

        res.status(200).json({
            message: 'Login successful',
            token,
            user: userWithoutPassword
        });

    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server login error' });
    }
};

module.exports = { login };