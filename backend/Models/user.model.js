import { Schema, model } from 'mongoose'
import { emailField, invalidEmailMsg, invalidPhoneMsg, phoneNumberField } from '../Utils/Schema-patterns.js';
import jwt from 'jsonwebtoken';

const userSchema = new Schema({
    fullname: {
        type: String,
        trim: true,
        required: true
    },
    email: {
        type: String,
        unique: true,
        trim: true,
        required: true,
        match: [emailField, invalidEmailMsg]
    },
    phone: {
        type: String,
        trim: true,
        required: true,
        match: [phoneNumberField, invalidPhoneMsg]
    },
    profile_pic: {
        url: { type: String, trim: true },
        publicId: { type: String, trim: true }
    },
    password: {
        type: String,
        required: true
    },
    role: {
        type: String,
        enum: ['user', 'admin', 'Owner'],
        default: 'user',
        required: true
    },
    address: {
        governorate: {
            type: String,
            trim: true
        },
        city: {
            type: String,
            trim: true
        },
        street: {
            type: String,
            trim: true,
        },
        details: {
            type: String,
            trim: true,
            default: ""
        }
    },
    otp: String,
    otpExpire: Date
}, { timestamps: true });

userSchema.methods.generateToken = function () {
    return jwt.sign(
        {
            id: this._id,
            role: this.role
        },
        process.env.JWT_SECRET,
        { expiresIn: '1h' }
    );
}

export const Users = model('User', userSchema);