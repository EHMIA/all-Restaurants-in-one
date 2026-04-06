import { object, string, ref } from 'joi';

const registerSchema = object({
    fullname: string().trim().min(3).max(30).required(),

    phone : string().trim().pattern(/^01[0-9]{9}$/).required(),

    email: string().trim().email().required(),

    password: string().trim().min(8).required(),

    confirmPassword: string().valid(ref('password')).required().messages({
        'any.only': 'Confirm password must match password'
    })
    
});

export  { registerSchema }; 