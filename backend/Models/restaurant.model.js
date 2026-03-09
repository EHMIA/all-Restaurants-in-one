import { model, Schema } from "mongoose"
import { emailField, invalidEmailMsg, hoursField, phoneNumberField, invalidPhoneMsg, photoField, invalidPhotoMsg } from "../Utils/Schema-patterns";

export const restaurantSchema = new Schema({
    email: {
        type: String,
        trim: true,
        required: true,
        unique: true,
        match: [emailField, invalidEmailMsg],
        lowercase:true
    },
    name: {
        type: String,
        trim: true,
        minlength: 3,
        maxlength: 50,
        unique: true,
        required: true
    },
    coverPhoto: {
        type: String,
        trim:true,
        match: [photoField,invalidPhotoMsg]
    },
    rating: {
        type: Number,
        required: true,
        min: 0,
        max: 5
    },
    delivery: {
        type: Boolean,
        required: true
    },
    priceRange: {
        type: String,
        trim:true,
        enum: ["low", "high", "medium"],
        required: true
    },
    facebookLink: {
        type: String,
        required: true,
        trim:true,
        match: [/^(https?:\/\/)?(?:www\.)?(?:facebook\.com|fb\.com)\/[a-zA-Z0-9_\-\.]+(?:\/\d+)?\/?$/i,'This Facebook link is invalid']
    },
    cuisineType: [{
        type: String,
        required: true,
        trim:true
    }],
    phoneNumber: {
        type: String,
        trim: true,
        required: true,
        match: [phoneNumberField,invalidPhoneMsg]
    },
    whatsappNumber: {
        type: String,
        trim: true,
        default: null,
        match: [phoneNumberField,invalidPhoneMsg]
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
            trim:true,
            default: ""
        },
    }],
    Gallery: [
        {
            type: String,
            trim: true,
            required: true,
            match: [photoField,invalidPhotoMsg]
        }
    ],
    menu: [
        {
            dishName: {
                type: String,
                required: true,
                trim: true
            },
            price: {
                type: Number,
                min: 0,
                required:true
            },
            Description: {
                type: String,
                trim: true,
                default: null
            },
            image: {
                type: String,
                trim: true,
                required: true,
                match: photoField
            },
            category: {
                type: String,
                required: true,
                enum: [
                    'Appetizers',
                    'Salads',
                    'Soups',
                    'Main Courses',
                    'Grills',
                    'Shawarma',
                    'Pasta',
                    'Pizza',
                    'Burgers & Sandwiches',
                    'Rice Dishes',
                    'Vegetarian',
                    'Sides',
                    'Desserts',
                    'Beverages'
                ],
            }
        }
    ],
    openingHours:[
        {
            day:{
                type:String,
                required:true,
                enum:['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
            },
            opens:{
                type:String,
                match:hoursField
            },
            closes:{
                type:String,
                match:hoursField
            },
            isClosed:{
                type:Boolean,
                default:false
            }
        }
    ]
},
    {
        timestamps: true
    });

    export const resturantModel = model("Restaurant", restaurantSchema);