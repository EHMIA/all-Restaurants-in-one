import { hash } from "bcrypt";
import { Users } from "../Models/user.model.js";
import { registerSchema } from "../Validators/register_validation.js";
import asyncHandler from "express-async-handler";

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

    const { password: _password, ...userWithoutPassword } = newUser.toObject();

    res.status(201).json({
        Token: token,
        user: {...userWithoutPassword, role: newUser.role },
    });
});

export { register };
