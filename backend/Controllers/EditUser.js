import { Users } from "../Models/user.model.js";
import asyncHandler from "express-async-handler";


const editUserProfile = asyncHandler(async (req, res) => {
    
    const targetId = req.user.role === "admin" ? req.params.id : req.user.id;

    const { fullname, email, phone, address, role } = req.body;

    let updateData = {};
    if (fullname) updateData.fullname = fullname;
    if (email)    updateData.email = email;
    if (phone)    updateData.phone = phone;
    
    if (req.user.role === "admin" && role) {
           updateData.role = role;
    }

    if (address) {
        if (address.governorate) updateData["address.governorate"] = address.governorate;
        if (address.city)        updateData["address.city"] = address.city;
        if (address.street)      updateData["address.street"] = address.street;
        if (address.details)     updateData["address.details"] = address.details;
    }

    const user = await Users.findByIdAndUpdate(
        targetId,
        { $set: updateData },
        { new: true, runValidators: true }
    );

    if (!user) {
        res.status(404);
        throw new Error("User not found");
    }

    const { password: _password, ...userWithoutPassword } = user.toObject();

    res.status(200).json({
        message: "Profile updated successfully",
        user: userWithoutPassword
    });
});


export { editUserProfile };