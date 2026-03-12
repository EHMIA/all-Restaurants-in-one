import { object, string, number, boolean, array } from "joi";
import { emailField, phoneNumberField, photoField, facebookLinkField, hoursField, invalidPhoneMsg } from "../Utils/Schema-patterns.js";
import { Days, CuisineTypes, MenuCategories, PriceRanges, LIMITS } from "../Utils/Constants.js";


const requiredString = (fieldName) => ({
    "any.required": `${fieldName} is required`,
    "string.empty": `${fieldName} cannot be empty`,
    "string.base": `${fieldName} must be a string`,
});


const createRestaurantValidation = (obj) => {
    const schema = object({
        email: string().trim().pattern(emailField).required()
            .messages(requiredString("Email")),

        name: string().trim().min(LIMITS.NAME_MIN).max(LIMITS.NAME_MAX).required()
            .messages(requiredString("Name")),

        coverPhoto: string().trim().pattern(photoField)
            .messages({ "string.pattern.base": "Invalid cover photo URL" }),

        rating: number().min(0).max(5).required()
            .messages({ "number.base": "Rating must be a number", "any.required": "Rating is required" }),

        delivery: boolean().required()
            .messages({ "any.required": "Delivery field is required" }),

        priceRange: string().trim().valid(...PriceRanges).required()
            .messages({ "any.only": "Price range must be low, medium, or high", "any.required": "Price range is required" }),

        facebookLink: string().trim().pattern(facebookLinkField).required()
            .messages({ "string.pattern.base": "Invalid Facebook link", "any.required": "Facebook link is required" }),

        cuisineType: array()
            .items(string().valid(...CuisineTypes).required())
            .min(1).max(LIMITS.CUISINE_TYPES).required()
            .messages({
                "array.base": "cuisineType must be an array",
                "array.min": "At least one cuisine type is required",
                "array.max": `Cannot add more than ${LIMITS.CUISINE_TYPES} cuisine types`,
                "any.required": "cuisineType is required",
                "any.only": "One or more cuisine types are invalid",
            }),

        phoneNumber: string().trim().pattern(phoneNumberField).required()
            .messages({ "string.pattern.base": invalidPhoneMsg, ...requiredString("Phone number") }),

        whatsappNumber: string().trim().pattern(phoneNumberField).allow(null).default(null)
            .messages({ "string.pattern.base": invalidPhoneMsg }),

        address: array()
            .items(object({
                governorate: string().trim().required().messages(requiredString("Governorate")),
                city:        string().trim().required().messages(requiredString("City")),
                street:      string().trim().required().messages(requiredString("Street")),
                details:     string().trim().allow("").default(""),
            }).required())
            .min(1).max(LIMITS.BRANCHES).required()
            .messages({
                "array.base": "Address must be an array",
                "array.min": "At least one address is required",
                "array.max": `Cannot add more than ${LIMITS.BRANCHES} addresses`,
                "any.required": "Address is required",
            }),

        Gallery: array()
            .items(string().pattern(photoField).messages({ "string.pattern.base": "Invalid photo URL" }))
            .max(LIMITS.GALLERY_PHOTOS)
            .messages({ "array.max": `Gallery cannot have more than ${LIMITS.GALLERY_PHOTOS} photos` }),

        menu: array()
            .items(object({
                dishName: string().trim().required().messages(requiredString("Dish name")),

                price: number().min(0).required().messages({
                    "number.base": "Price must be a number",
                    "number.min": "Price cannot be negative",
                    "any.required": "Price is required",
                }),

                description: string().trim().allow(null, "").default(null),

                image: string().trim().pattern(photoField).required().messages({
                    "string.pattern.base": "Invalid image URL",
                    "any.required": "Image is required",
                }),

                category: string().valid(...MenuCategories).required().messages({
                    "any.only": "Invalid category",
                    "any.required": "Category is required",
                }),
            }))
            .max(LIMITS.MENU_ITEMS)
            .messages({ "array.max": `Menu cannot have more than ${LIMITS.MENU_ITEMS} dishes` }),

        openingHours: array().items(object({
            day: string().valid(...Days).required().messages({
                "any.only": "Invalid day of the week",
                "any.required": "Day is required",
            }),

            opens: string().pattern(hoursField)
                .when("isClosed", {
                    is: false,
                    then: string().required(),
                    otherwise: string().allow(null, "").default(null),
                })
                .messages({
                    "string.pattern.base": "Opening time must be in HH:mm format",
                    "any.required": "Opening time is required when restaurant is open",
                }),

            closes: string().pattern(hoursField)
                .when("isClosed", {
                    is: false,
                    then: string().required(),
                    otherwise: string().allow(null, "").default(null),
                })
                .messages({
                    "string.pattern.base": "Closing time must be in HH:mm format",
                    "any.required": "Closing time is required when restaurant is open",
                }),

            isClosed: boolean().default(false),
        })),
    });

    return schema.validate(obj); 
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