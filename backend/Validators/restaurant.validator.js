import joi from "joi";
import { emailField, phoneNumberField, facebookLinkField, hoursField, invalidPhoneMsg } from "../Utils/Schema-patterns.js";
import { Days, CuisineTypes, MenuCategories, PriceRanges, LIMITS } from "../Utils/Constants.js";



const requiredString = (fieldName) => ({
    "any.required": `${fieldName} is required`,
    "string.empty": `${fieldName} cannot be empty`,
    "string.base": `${fieldName} must be a string`,
});

const createRestaurantValidation = (obj) => {
    const schema = joi.object({
        email: joi.string().trim().pattern(emailField).required(),
        name: joi.string().trim().min(LIMITS.NAME_MIN).max(LIMITS.NAME_MAX).required(),
        phoneNumber: joi.string().trim().pattern(phoneNumberField).required(),
        cuisineType: joi.array().items(joi.string().valid(...CuisineTypes)).min(1).required(),
        delivery: joi.boolean().required(),
        Gallery: joi.array().items(joi.string()).min(4).required()
            .messages({
                "array.min": "Gallery must have at least 4 photos",
                "any.required": "Gallery is required"
            }),

        openingHours: joi.array().items(joi.object({
            day: joi.string().valid(...Days).required(),
            opens: joi.string().allow(null, ""),
            closes: joi.string().allow(null, ""),
            isClosed: joi.boolean().default(false)
        })).min(1).required(),

        address: joi.array().items(joi.object({
            governorate: joi.string().required(),
            city: joi.string().required(),
            street: joi.string().required(),
            details: joi.string().allow("").default(""),
        })).min(1).required(),

        description: joi.string().max(LIMITS.DESCRIPTION_MAX).allow(""), 
        coverPhoto: joi.string().allow(null, ""), 
        facebookLink: joi.string().allow(null, ""),
        whatsappNumber: joi.string().allow(null, ""),
        menu: joi.array().items(joi.object()).default([]),
    });

    return schema.validate(obj, { convert: true });
};
const CalculateOpenNow=(restaurant)=>{
    const dateNow= new Date();
    const Today= Days[dateNow.getDay()];
    const hourNow= dateNow.getHours();
    const minuteNow= dateNow.getMinutes();

    // return openingHour one object
    const todayHours = restaurant.openingHours.find(OPH => OPH.day === Today);

    if(!todayHours || todayHours.isClosed){ 
        return false;
    }else{
        const [openH, openM] = todayHours.opens.split(":").map(Number);
        const [closeH, closeM] = todayHours.closes.split(":").map(Number);
        const openingTime=openH * 60 + openM;
        const closingTime= closeH * 60 + closeM;

        const TimeNow = hourNow*60+minuteNow;

        return TimeNow >= openingTime && TimeNow < closingTime;
    }
}

export  { 
    createRestaurantValidation ,
    CalculateOpenNow
};

