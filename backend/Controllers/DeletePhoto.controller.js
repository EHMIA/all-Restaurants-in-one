import { Users } from "../Models/user.model.js";
import asyncHandler from "express-async-handler";
import { v2 as cloudinary } from 'cloudinary'; 

const deleteProfilePicController = asyncHandler(async(req,res)=>{
    const targetId = req.user.role === "admin" ? req.params.id : req.user.id;

    const user = await Users.findById(targetId);

    if(!user)
        return res.status(404).json({message:"User not found"});

    // if (user.profile_pic_public_id) {

    //     const result = await cloudinary.uploader.destroy(user.profile_pic_public_id);
        
    //     if (result.result !== 'ok') {
    //         console.log("Cloudinary Delete Error:", result);
    //     }
    // }

    user.profile_pic="";
    // user.profile_pic_public_id = ""; 
    await user.save();
    res.status(200).json({message:"Profile picture deleted successfully"});
})

export {deleteProfilePicController}