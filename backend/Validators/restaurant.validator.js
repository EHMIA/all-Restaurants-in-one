import joi from "joi";
import { emailField, phoneNumberField } from "../Utils/Schema-patterns.js";
import { Days, CuisineTypes, LIMITS } from "../Utils/Constants.js";

const createRestaurantValidation = (obj) => {
    const schema = joi.object({
        email: joi.string().trim().pattern(emailField).required(),
        name: joi.string().trim().min(LIMITS.NAME_MIN).max(LIMITS.NAME_MAX).required(),
        phoneNumber: joi.string().trim().pattern(phoneNumberField).required(),
        cuisineType: joi.array().items(joi.string().valid(...CuisineTypes)).min(1).required(),
        delivery: joi.boolean().required(),


        coverPhoto: joi.any().required().messages({
            "any.required": "Cover image is required"
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
        facebookLink: joi.string().allow(null, ""),
        whatsappNumber: joi.string().allow(null, ""),
        menu: joi.array().items(joi.object()).default([]),
    });

    return schema.validate(obj, { convert: true, stripUnknown: true });
};
const CalculateOpenNow = (restaurant) => {

    const dateNow = new Date(new Date().toLocaleString("en-US", { timeZone: "Africa/Cairo" }));

    const Today = Days[dateNow.getDay()];
    const hourNow = dateNow.getHours();
    const minuteNow = dateNow.getMinutes();
    const TimeNow = hourNow * 60 + minuteNow;

    const todayHours = restaurant.openingHours.find(OPH => OPH.day === Today);

    if (!todayHours || todayHours.isClosed || !todayHours.opens || !todayHours.closes) {
        return false;
    }

    const [openH, openM] = todayHours.opens.split(":").map(Number);
    const [closeH, closeM] = todayHours.closes.split(":").map(Number);

    let openingTime = openH * 60 + openM;
    let closingTime = closeH * 60 + closeM;


    if (closingTime <= openingTime) {

        if (TimeNow < closingTime) {
            return true;
        }

        closingTime += 24 * 60;
    }

    return TimeNow >= openingTime && TimeNow < closingTime;
}


const addReviewValidation = (obj) => {
    const schema = joi.object({
        title: joi.string().trim().min(3).max(30).default("Review for restaurant"),
        Content: joi.string().trim().min(5).max(500).required(),
        rating: joi.number().min(1).max(5).required(),
    });
    return schema.validate(obj);
}
export {
    createRestaurantValidation,
    CalculateOpenNow,
    addReviewValidation
};

