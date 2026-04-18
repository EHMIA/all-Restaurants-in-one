import { Schema, model } from "mongoose"

const SettingsSchema = new Schema(
    {
        lowMax: { type: Number, default: 150 },
        mediumMax: { type: Number, default: 400 },
    },
    {
        timestamps: true
    }
)

export const  Settings= model("Setting", SettingsSchema);