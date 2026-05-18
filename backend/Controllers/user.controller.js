import { Users } from '../Models/user.model.js';
import { reviewModel } from "../Models/reviews.model.js";
import { restaurantModel } from "../Models/restaurant.model.js";
import { favResModel } from "../Models/FavoriteRestaurants.model.js";

import asyncHandler from "express-async-handler";
import { uploadToCloudinary } from "../Utils/cloudinary.util.js";
import { compare, hash } from 'bcrypt';
import { v2 as cloudinary } from 'cloudinary'; 


const getUserProfile = asyncHandler(async (req, res) => {
    const userId = req.params.id;
    const [user, reviewsCount, favoritesCount, hasRestaurant] = await Promise.all([
        Users.findById(userId).select('-password'),
        reviewModel.countDocuments({ user: userId }),
        favResModel.countDocuments({ user: userId }),
        restaurantModel.exists({ Owner: userId }) 
    ]);

    if (!user) {
        return res.status(404).json({ error: 'User not found' });
    }

    res.status(200).json({
        success: true,
        user: {
            ...user._doc,
            reviewsCount,
            favoritesCount,
            isRestaurantOwner: hasRestaurant ? true : false 
        }
    });
});


//======================================================//


const getAllUsers = asyncHandler(async (req, res) => {
    let { page, limit, searchQuery } = req.query;

    page = parseInt(page) || 1;
    limit = parseInt(limit) || 10;
    const skip = (page - 1) * limit;

    let conditions = {};
    if (searchQuery) {
        conditions.fullname = { $regex: String(searchQuery), $options: "i" };
    }

    // 1. ضفنا "absoluteTotal" هنا عشان نعد كل المستخدمين بدون أي فلاتر
    const [users, filteredCount, absoluteTotal] = await Promise.all([
        Users.find(conditions)
            .select("-password")
            .sort({ createdAt: -1 })
            .skip(skip)
            .limit(limit),
        Users.countDocuments(conditions), // عد نتائج البحث فقط (عشان الصفحات)
        Users.countDocuments({})         // عد كل اليوزرز في الداتابيز (بدون شروط)
    ]);

    res.status(200).json({
        success: true,
        data: users,
        meta: {
            totalInDatabase: absoluteTotal, // ده الرقم اللي هيتحط في خانة "Total Users" فوق في الـ Figma
            foundResults: filteredCount,    // ده عدد النتائج اللي طلعت من البحث
            pagesCount: Math.ceil(filteredCount / limit), // الصفحات بتتحسب دايماً على قد اللي لقيناه بس
            currentPage: page,
            limit
        }
    });
});
//======================================================//


const editUserProfile = asyncHandler(async (req, res) => {

    const targetId = req.user.role === "admin" ? req.params.id : req.user.id;

    const { fullname, email, phone, address, role } = req.body;

    let updateData = {};
    if (fullname) updateData.fullname = fullname;
    if (email) 
    {
        const existingUser = await Users.findOne({ email, _id: { $ne: targetId } });
        if (existingUser) {
            return res.status(400).json({ message: "Email is already in use by another account" });
        }
        updateData.email = email;
    }
    if (phone) updateData.phone = phone;

    if (role) {
        if (req.user.role !== "admin") {
            return res.status(403).json({ message: "Only admins can change user roles" });
        }

        if (!["user", "owner", "admin"].includes(role)) {
            return res.status(400).json({ message: "Invalid role specified must be 'user', 'owner', or 'admin'" });
        }
        
        if (role === "admin") {
            const restaurant = await restaurantModel.findOne({ Owner: targetId });
            if (restaurant) {
                return res.status(400).json({ message: "Cannot change role to admin. User should not have an associated restaurant to be admin." });
            }
             
        }
        updateData.role = role;
    }
    else if (role) {
        return res.status(403).json({ message: "Only admins can change user roles" });
    }

    if (address && typeof address === 'object') {
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


// const uploadProfilePicController = asyncHandler(async (req, res) => {
//     if (!req.file) {
//         return res.status(400).json({ message: "Please upload an image" });
//     }

//     const imageUrl = await uploadToCloudinary(req.file.buffer);

//     const updatedUser = await Users.findByIdAndUpdate(
//         req.user.id,
//         { profile_pic: imageUrl },
//         { new: true, runValidators: true },
//     );

//     if (!updatedUser) {
//         return res.status(404).json({ message: "User not found" });
//     }

//     res.status(200).json({
//         message: "Profile picture updated successfully",
//         profile_pic: updatedUser.profile_pic,
//     });
// });

const uploadProfilePicController = asyncHandler(async (req, res) => {
    if (!req.file) {
        return res.status(400).json({ message: "Please upload an image" });
    }

    const user = await Users.findById(req.user.id);
    if (!user) return res.status(404).json({ message: "User not found" });

    if (user.profile_pic && user.profile_pic.publicId) {
        await cloudinary.uploader.destroy(user.profile_pic.publicId);
    }

    const cloudRes = await uploadToCloudinary(req.file.buffer);

    user.profile_pic = {
        url: cloudRes.url,
        publicId: cloudRes.publicId
    };

    await user.save();

    res.status(200).json({
        message: "Profile picture updated successfully",
        profile_pic: user.profile_pic,
    });
});

//======================================================//


// const deleteProfilePicController = asyncHandler(async (req, res) => {
//     const targetId = req.user.role === "admin" ? req.params.id : req.user.id;

//     const user = await Users.findById(targetId);

//     if (!user)
//         return res.status(404).json({ message: "User not found" });

//     // if (user.profile_pic_public_id) {

//     //     const result = await cloudinary.uploader.destroy(user.profile_pic_public_id);

//     //     if (result.result !== 'ok') {
//     //         console.log("Cloudinary Delete Error:", result);
//     //     }
//     // }

//     user.profile_pic = "";
//     // user.profile_pic_public_id = ""; 
//     await user.save();
//     res.status(200).json({ message: "Profile picture deleted successfully" });
// });

const deleteProfilePicController = asyncHandler(async (req, res) => {
    const targetId = req.user.role === "admin" ? req.params.id : req.user.id;
    const user = await Users.findById(targetId);

    if (!user) return res.status(404).json({ message: "User not found" });

    if (user.profile_pic?.publicId) {
        await cloudinary.uploader.destroy(user.profile_pic.publicId);
    }

    user.profile_pic = null;
    await user.save();

    res.status(200).json({ message: "Profile picture deleted successfully" });
});


//======================================================//


const changePasswordController = asyncHandler(async (req, res) => {
    const { currentPassword, newPassword , confirmPassword} = req.body;  
    const user = await Users.findById(req.user.id);

    if (!user) {
        return res.status(404).json({ message: "User not found" });
    }

    const isMatch = await compare(currentPassword, user.password);
    // const isMatch = await checkPassword(currentPassword, user.password);
    if (!isMatch) {
        return res.status(400).json({ message: "Current password is incorrect" });
    }
    
    if (newPassword !== confirmPassword) {
        return res.status(400).json({ message: "New passwords do not match" });
    }

    const hashedPassword = await hash(newPassword, 10);
    
    user.password = hashedPassword; // Ensure this will be hashed in the model's pre-save hook
    await user.save();
    res.status(200).json({ message: "Password changed successfully" });


})


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
        const restaurant = await restaurantModel.findOne({ Owner: targetId });
        if (restaurant) {
            await reviewModel.deleteMany({ restaurant: restaurant._id });
            await restaurantModel.deleteOne({ _id: restaurant._id });
        }
    }

    if (userToDelete.role === "owner") {
        const restaurant = await restaurantModel.findOne({ Owner: targetId });
        if (restaurant) {
            await Promise.all([
            reviewModel.deleteMany({ restaurant: restaurant._id }),
            favResModel.deleteMany({ restaurant: restaurant._id }),
            restaurantModel.deleteOne({ _id: restaurant._id })
        ]);
            // await reviewModel.deleteMany({ restaurant: restaurant._id });
            // await favResModel.deleteMany({ restaurant: restaurant._id });
            // await restaurantModel.deleteOne({ _id: restaurant._id });
        }
    }

    await favResModel.deleteMany({ user: targetId });
    await Users.findByIdAndDelete(targetId);

    res.status(200).json({ message: "Account and related data deleted successfully" });
});


export { 
        getUserProfile, 
        uploadProfilePicController, 
        editUserProfile,
        deleteProfilePicController,
        deleteAccountController, 
        changePasswordController ,
        getAllUsers
    };