import { Schema, model } from "mongoose"

const favResScehma = new Schema(
    {
        restaurant: [{
            type: Schema.Types.ObjectId,
            required: true,
            ref: "Restaurant"
        }],
        user: {
            type: Schema.Types.ObjectId,
            required: true,
            ref: "User"
        }
    },
    {
        timestamps: true
    }
)

export const favResModel=model("FavoriteRestaurant",favResScehma);