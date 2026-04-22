import joi from "joi";
import { emailField, phoneNumberField } from "../Utils/Schema-patterns.js";
import {
    Days,
    CuisineTypes,
    LIMITS,
    MenuCategories,
} from "../Utils/Constants.util.js";

const createRestaurantValidation = (obj) => {
    const schema = joi.object({
        email: joi.string().trim().pattern(emailField).required(),
        name: joi
            .string()
            .trim()
            .min(LIMITS.NAME_MIN)
            .max(LIMITS.NAME_MAX)
            .required(),
        phoneNumber: joi.string().trim().pattern(phoneNumberField).required(),
        cuisineType: joi
            .array()
            .items(joi.string().valid(...CuisineTypes))
            .min(1)
            .required(),
        delivery: joi.boolean().required(),

        coverPhoto: joi.any().required().messages({
            "any.required": "Cover image is required",
        }),
        openingHours: joi
            .array()
            .items(
                joi.object({
                    day: joi
                        .string()
                        .valid(...Days)
                        .required(),
                    opens: joi.string().allow(null, ""),
                    closes: joi.string().allow(null, ""),
                    isClosed: joi.boolean().default(false),
                }),
            )
            .min(1)
            .required(),

        address: joi
            .array()
            .items(
                joi.object({
                    governorate: joi.string().required(),
                    city: joi.string().required(),
                    street: joi.string().required(),
                    details: joi.string().allow("").default(""),
                }),
            )
            .min(1)
            .required(),

        description: joi.alternatives().try(
                                        joi.string().valid(""), 
                                        joi.string().min(LIMITS.DESCRIPTION_MIN) 
    ),
        facebookLink: joi.string().allow(null, ""),
        whatsappNumber: joi.string().allow(null, ""),
        menu: joi.array().items(joi.object()).default([]),
    });
    return schema.validate(obj, { convert: true, stripUnknown: true });
};

const addDishsToMenuValidation = (obj) => {
    const schema = joi.object({
        menu: joi
            .array()
            .items(
                joi.object({
                    dishName: joi.string().trim().required(),
                    price: joi.number().min(0).required(),
                    description: joi.string().trim().allow(""),
                    image: joi.any().optional(),
                    category: joi
                        .string()
                        .insensitive()
                        .valid(...MenuCategories)
                        .required()
                        .messages({
                            "any.only": "Category must be Food, Drink, or Dessert",
                        }),
                }),
            )
            .min(1)
            .required(),
    });
    return schema.validate(obj);
};

const editDishInMenuValidation = (obj) => {
    const schema = joi.object({
        dishName: joi.string().trim(),
        price: joi.number().min(0),
        description: joi.string().trim().allow(""),
        image: joi.any().optional(),
        category: joi
            .string()
            .insensitive()
            .valid(...MenuCategories)
            .messages({
                "any.only": "Category must be Food, Drink, or Dessert",
            }),
    });
    return schema.validate(obj);
};



const addReviewValidation = (obj) => {
    const schema = joi.object({
        Content: joi.string().trim().min(5).max(500).required(),
        rating: joi.number().min(1).max(5).required(),
    });
    return schema.validate(obj);
};

export {
    createRestaurantValidation,
    addReviewValidation,
    addDishsToMenuValidation,
    editDishInMenuValidation,
};
