import { restaurantSchema } from "../Models/restaurant.model";

const photoField =
    /^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_+.~#?&/=]*)\.(jpe?g|png|gif|webp|svg|bmp|ico|tiff?)$/i;
const emailField = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
const phoneNumberField = /^010[0-2,5][0-9]{8}$/;
const hoursField = /^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/;

// invalid msgs
const invalidPhotoMsg = "Invalid image url";
const invalidEmailMsg = "Invalid email";
const invalidPhoneMsg = "Invalid phone number";

// array validators
restaurantSchema
    .path("menu")
    .validate((menu) => menu.length <= 10, "Menu already have 10 dishs");

restaurantSchema
    .path("Gallery")
    .validate((gall) => gall.length <= 40, "You can't add more than 40  photos");

restaurantSchema
    .path("address")
    .validate(
        (ADS) => ADS.length <= 5,
        "You can't add more than 5 branches addresses",
    );
    
restaurantSchema
    .path("cuisineType")
    .validate(
        (CUTY) => CUTY.length <= 5,
        "You can't add more than 5 cuisine types",
    );

restaurantSchema.path("openingHours").validate((OPHo) => {
    for (const hour of OPHo) {
        if (hour.isClosed) {
            if (!hour.opens || !hour.closes) {
                throw new Error(
                    "Opens and closes time is required when restaurant is open",
                );
            }

            // calculate open and close time
            const [openHour, openMinute] = hour.opens.split(":").map(Number);
            const [closeHour, closeMinute] = hour.closes.split(":").map(Number);

            const openTime = openHour * 60 + openMinute;
            const closeTime = closeHour * 60 + closeMinute;
            if (openTime >= closeTime) {
                throw new Error(
                    `Open time must be smaller than close time in day ${hour.day}`,
                );
            }
        }
    }
    return true;
});

export {
    phoneNumberField,
    photoField,
    emailField,
    hoursField,
    invalidEmailMsg,
    invalidPhotoMsg,
    invalidPhoneMsg,
};
