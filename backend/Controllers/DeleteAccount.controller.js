import { Users } from "../Models/user.model.js";
import { reviewModel } from "../Models/reviews.model.js";
import {restaurantModel} from "../Models/restaurant.model.js";
import {favResModel } from "../Models/FavoriteRestaurants.model.js";
import asyncHandler from "express-async-handler";

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