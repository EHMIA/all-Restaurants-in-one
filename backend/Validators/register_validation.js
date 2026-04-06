const Joi = require('joi');

const registerSchema = Joi.object({
    fullname: Joi.string().min(3).max(30).required(),

    phone : Joi.string().pattern(/^01[0-9]{9}$/).required(),

    email: Joi.string().email().required(),

    password: Joi.string().min(8).required(),

    confirmPassword: Joi.string().valid(Joi.ref('password')).required().messages({
        'any.only': 'Confirm password must match password'
    })
    
});

module.exports = { registerSchema };