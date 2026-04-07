import Joi from 'joi';

const registerSchema = Joi.object({
    fullname: Joi.string().trim().min(3).max(30).required(),

    phone : Joi.string().trim().pattern(/^01[0125][0-9]{8}$/).required(),

    email: Joi.string().trim().required(),

    password: Joi.string().trim().min(8).required(),

    confirmPassword: Joi.string().valid(Joi.ref('password')).required().messages({
        'any.only': 'Confirm password must match password'
    })
    
});

export  { registerSchema }; 