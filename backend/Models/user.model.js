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
        type: String,
        required: true,
        default: "https://avatars.hsoubcdn.com/725a4674fbb20a98fc72f205e9c359f8?s=256",
        match: [photoField, invalidPhotoMsg],
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
    address: [{
        governorate: {
            type: String,
            required: true,
            trim: true
        },
        city: {
            type: String,
            required: true,
            trim: true
        },
        street: {
            type: String,
            trim: true,
            required: true
        },
        details: {
            type: String,
            trim: true,
            default: ""
        }
    }],
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
        { expiresIn: '15m' }
    );
}

export const Users = model('User', userSchema);