import { Users } from '../Models/user.model.js';
import { reviewModel } from "../Models/reviews.model.js";
import { restaurantModel } from "../Models/restaurant.model.js";
import { favResModel } from "../Models/FavoriteRestaurants.model.js";
import asyncHandler from "express-async-handler";
import { uploadToCloudinary } from "../Utils/cloudinary.util.js";
import { v2 as cloudinary } from 'cloudinary';



const getUserProfile = asyncHandler(async (req, res) => {
    const user = await Users.findOne({ _id: req.user.id }).select('-password');
    // const user = await Users.findOne({ _id: req.user.id }).select('-password');

    if (!user) {
        return res.status(404).json({ error: 'User not found' });
    }

    res.status(200).json({
        message: 'User profile retrieved successfully',
        user
    });
});


//======================================================//


const uploadProfilePicController = asyncHandler(async (req, res) => {
    if (!req.file) {
        return res.status(400).json({ message: "Please upload an image" });
    }

    const imageUrl = await uploadToCloudinary(req.file.buffer);

    const updatedUser = await Users.findByIdAndUpdate(
        req.user.id,
        { profile_pic: imageUrl },
        { new: true, runValidators: true },
    );

    if (!updatedUser) {
        return res.status(404).json({ message: "User not found" });
    }

    res.status(200).json({
        message: "Profile picture updated successfully",
        profile_pic: updatedUser.profile_pic,
    });
});


//======================================================//


const deleteProfilePicController = asyncHandler(async (req, res) => {
    const targetId = req.user.role === "admin" ? req.params.id : req.user.id;

    const user = await Users.findById(targetId);

    if (!user)
        return res.status(404).json({ message: "User not found" });

    // if (user.profile_pic_public_id) {

    //     const result = await cloudinary.uploader.destroy(user.profile_pic_public_id);

    //     if (result.result !== 'ok') {
    //         console.log("Cloudinary Delete Error:", result);
    //     }
    // }

    user.profile_pic = "";
    // user.profile_pic_public_id = ""; 
    await user.save();
    res.status(200).json({ message: "Profile picture deleted successfully" });
});


//======================================================//


const editUserProfile = asyncHandler(async (req, res) => {

    const targetId = req.user.role === "admin" ? req.params.id : req.user.id;

    const { fullname, email, phone, address, role } = req.body;

    let updateData = {};
    if (fullname) updateData.fullname = fullname;
    if (email) updateData.email = email;
    if (phone) updateData.phone = phone;

    if (req.user.role === "admin" && role) {
        updateData.role = role;
    }

    if (address) {
        if (address.governorate) updateData["address.governorate"] = address.governorate;
        if (address.city) updateData["address.city"] = address.city;
        if (address.street) updateData["address.street"] = address.street;
        if (address.details) updateData["address.details"] = address.details;
    }

    const user = await Users.findByIdAndUpdate(
        targetId,
        { $set: updateData },
        { returnDocument: 'after', runValidators: true }
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


//======================================================//


const deleteAccountController = asyncHandler(async (req, res) => {
    const { id } = req.params;
    const currentUser = req.user;

    const targetId = (currentUser.role === "admin" && id) ? id : currentUser.id;

    const userToDelete = await Users.findById(targetId);
    if (!userToDelete) {
        return res.status(404).json({ message: "User not found" });
    }

    if (userToDelete.role === 'admin') {
        const adminCount = await Users.countDocuments({ role: 'admin' });
        if (adminCount <= 1) {
            return res.status(400).json({ message: "Cannot delete the last admin account" });
        }
        const restaurant = await restaurantModel.findOne({ owner: targetId });
        if (restaurant) {
            await reviewModel.deleteMany({ restaurant: restaurant._id });
            await restaurantModel.deleteOne({ _id: restaurant._id });
        }
    }

    if (userToDelete.role === "owner") {
        const restaurant = await restaurantModel.findOne({ owner: targetId });
        if (restaurant) {
            await reviewModel.deleteMany({ restaurant: restaurant._id });
            await restaurantModel.deleteOne({ _id: restaurant._id });
        }
    }

    await favResModel.deleteMany({ user: targetId });
    await Users.findByIdAndDelete(targetId);

    res.status(200).json({ message: "Account and related data deleted successfully" });
});


export { getUserProfile, uploadProfilePicController, editUserProfile, deleteProfilePicController, deleteAccountController };