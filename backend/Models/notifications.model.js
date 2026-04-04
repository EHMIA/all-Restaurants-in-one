import { Schema,model } from "mongoose";

const notificationSchema=new Schema({
    receiver: {
        type: Schema.Types.ObjectId,
        required: true,
        ref: "User"
    },
        sender: {
        type: Schema.Types.ObjectId,
        required: true,
        ref: "User"
    },
    restaurant: {
        type: Schema.Types.ObjectId,
        required: true,
        ref: "Restaurant"
    },
    message: {
        type: String,
        trim: true,
        required: true
    },
    isRead: {
        type: Boolean,
        default: false
    },
    type: {
        type: String,
        enum: ["pending", "accepted", "rejected"],
        required: true
    },

},
{
    timestamps: true
})


export const notificationModel=model("Notification",notificationSchema);
