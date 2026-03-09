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
        maxlength:100,
        required:true
    },
    rating: {
        type: Number,
        required: true,
        min: 0,
        max: 5
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


export const reviewModel=model("Review",reviewSchema);