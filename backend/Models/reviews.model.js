import {Schema,model} from "mongoose"

const reviewSchema=new Schema({
    title:{
        type:String,
        trim:true,
        minlength:3,
        maxlength:30
    },
    Content:{
        type:String,
        trim:true,
        minlength:5,
        maxlength:500,
        required:true
    },
    rating: {
        type: Number,
        default: 0,
        min: 0,
        max: 5,
        required: true
    },
    restaurant:{
        type:Schema.Types.ObjectId,
        required:true,
        ref:"Restaurant"
    },
    user:{
        type:Schema.Types.ObjectId,
        required:true,
        ref:"User"
    }
},
{
    timestamps:true
});

reviewSchema.index({ restaurant: 1, user: 1 }, { unique: true });


export const reviewModel=model("Review",reviewSchema);