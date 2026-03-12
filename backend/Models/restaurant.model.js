import { model, Schema } from "mongoose";
import {
    photoField,
    phoneNumberField,
    invalidPhoneMsg,
} from "../Utils/Schema-patterns.js";
import {
    Days,
    CuisineTypes,
    MenuCategories,
    PriceRanges,
    RestaurantStatuses,
    LIMITS,
} from "../Utils/Constants.js";

const restaurantSchema = new Schema(
    {
        email: {
            type: String,
            trim: true,
            required: true,
            unique: true,
        },
        name: {
            type: String,
            trim: true,
            minlength: LIMITS.NAME_MIN,
            maxlength: LIMITS.NAME_MAX,
            unique: true,
            required: true,
        },

        coverPhoto: {
            type: String,
            trim: true,
        },

        rating: {
            type: Number,
            required: true,
            min: 0,
            max: 5,
        },

        delivery: {
            type: Boolean,
            required: true,
        },

        priceRange: {
            type: String,
            trim: true,
            enum: PriceRanges,
            required: true,
        },

        facebookLink: {
            type: String,
            required: true,
            trim: true,
        },

        cuisineType: [
            {
                type: String,
                required: true,
                trim: true,
                enum: CuisineTypes,
            },
        ],

        phoneNumber: {
            type: String,
            trim: true,
            required: true,
            match: [phoneNumberField, invalidPhoneMsg],
        },

        whatsappNumber: {
            type: String,
            trim: true,
            default: null,
            match: [phoneNumberField, invalidPhoneMsg],
        },

        address: [
            {
                governorate: {
                    type: String,
                    required: true,
                    trim: true,
                },
                city: {
                    type: String,
                    required: true,
                    trim: true,
                },
                street: {
                    type: String,
                    required: true,
                    trim: true,
                },
                details: {
                    type: String,
                    trim: true,
                    default: "",
                },
            },
        ],

        Gallery: [
            {
                type: String,
                trim: true,
                match: [photoField, "Invalid photo URL"],
            },
        ],

        menu: [
            {
                dishName: { type: String, required: true, trim: true },
                price: { type: Number, min: 0, required: true },
                description: { type: String, trim: true, default: null },
                image: {
                    type: String,
                    trim: true,
                    required: true,
                    match: [photoField, "Invalid image URL"],
                },
                category: { type: String, required: true, enum: MenuCategories },
            },
        ],

        openingHours: [
            {
                day: { type: String, required: true, enum: Days , lowercase: true},
                opens: { type: String, trim: true, default: null, lowercase: true },
                closes: { type: String, trim: true, default: null,lowercase: true },
                isClosed: { type: Boolean, default: false },
            },
        ],

        status: { type: String, enum: RestaurantStatuses, default: "pending" },
    },
    { timestamps: true },
);



// custome validators

restaurantSchema
    .path("menu")
    .validate(
        (menu) => menu.length <= LIMITS.MENU_ITEMS,
        `Menu cannot have more than ${LIMITS.MENU_ITEMS} dishes`,
    );

restaurantSchema
    .path("Gallery")
    .validate(
        (gallery) => gallery.length <= LIMITS.GALLERY_PHOTOS,
        `Gallery cannot have more than ${LIMITS.GALLERY_PHOTOS} photos`,
    );

restaurantSchema
    .path("address")
    .validate(
        (addresses) => addresses.length <= LIMITS.BRANCHES,
        `Cannot add more than ${LIMITS.BRANCHES} branch addresses`,
    );

restaurantSchema
    .path("cuisineType")
    .validate(
        (types) => types.length <= LIMITS.CUISINE_TYPES,
        `Cannot add more than ${LIMITS.CUISINE_TYPES} cuisine types`,
    );

restaurantSchema.path("openingHours").validate((hours) => {
    for (const hour of hours) {
        if (!hour.isClosed) {
            if (!hour.opens || !hour.closes) {
                throw new Error(
                    "Opens and closes time are required when restaurant is open",
                );
            }
            const [openH, openM] = hour.opens.split(":").map(Number);
            const [closeH, closeM] = hour.closes.split(":").map(Number);

            if (openH * 60 + openM >= closeH * 60 + closeM) {
                throw new Error(`Open time must be before close time on ${hour.day}`);
            }
        }
    }
    return true;
});

export const restaurantModel = model("Restaurant", restaurantSchema);
