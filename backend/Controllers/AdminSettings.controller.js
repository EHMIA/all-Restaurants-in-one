import asyncHandler from "express-async-handler"
import { Settings } from "../Models/adminSettings.model.js"
import { settingsValidation, validateRequest } from "../Validators/adminSetting.validation.js";
import { addRecalculatePricesJob } from "../Jobs/restaurantQueue.job.js";
import { restaurantModel } from "../Models/restaurant.model.js";
import { updateRestaurantStatus } from "../Services/restaurant.service.js";
import { notificationModel } from "../Models/notifications.model.js";
import { Users } from "../Models/user.model.js";
import { getSettingsService } from "../Services/adminSetting.service.js";
import { reviewModel } from "../Models/reviews.model.js";
import { favResModel } from "../Models/FavoriteRestaurants.model.js";

const getSystemSettings = asyncHandler(async (req, res) => {
    let settings_ = await getSettingsService();
    return res.status(200).json({ settings: settings_ });
});

const updateSysSettings = asyncHandler(async (req, res) => {
    const { error } = settingsValidation(req.body);
    if (error) return res.status(400).json({ message: error.details[0].message });

    const oldSettings = await Settings.findOne();

    const updatedSettings = await Settings.findOneAndUpdate(
        {}, 
        { $set: req.body }, 
        { new: true, upsert: true, runValidators: true }
    );

    const pricesChanged = 
        (req.body.lowMax !== undefined && req.body.lowMax !== oldSettings?.lowMax) || 
        (req.body.mediumMax !== undefined && req.body.mediumMax !== oldSettings?.mediumMax);

    if (pricesChanged) {
        await addRecalculatePricesJob({ 
            lowMax: updatedSettings.lowMax, 
            mediumMax: updatedSettings.mediumMax 
        });
    }

    res.status(200).json({ 
        message: pricesChanged 
            ? "Settings updated and background recalculation for prices started." 
            : "Settings updated successfully.",
        settings: updatedSettings 
    });
});


const getRestaurantRequests = asyncHandler(async (req, res) => {
    const requests = await restaurantModel.find({ 
        status: { $in: ["pending", "rejected"] } 
    })
    .select("_id name coverPhoto rejectionCount  createdAt")
    .populate("Owner", " fullname") 
    .sort({ createdAt: -1 }); 

    if (requests.length === 0) {
        return res.status(404).json({ message: "No requests found" });
    }

    return res.status(200).json({ 
        message: "Requests retrieved successfully",
        RequestsCount: requests.length,
        Data: requests 
    });
});


const getOneRequest = asyncHandler(async (req, res) => {
    const restaurantId= req.params.restaurantId;
    const request = await restaurantModel.findById(restaurantId)
        .select("_id name coverPhoto rejectionCount status createdAt Owner email  phoneNumber whatsappNumber address openingHours cuisineType delivery ")
        .populate("Owner", "_id fullname profile_pic"); 

    if (!request) {
        return res.status(404).json({ message: "Request not found" });
    }
    return res.status(200).json({ 
        message: "Request retrieved successfully",
        Data: request
    });
});



const acceptRejectRequest = asyncHandler(async (req, res) => {
    const { error } = validateRequest(req.body);
    if (error)
        return res.status(400).json({ message: error.details[0].message });

    const { action, reason } = req.body;
    const restaurantId = req.params.restaurantId;
    const AdminId = req.user.id;

    const restaurant = await restaurantModel.findById(restaurantId);
    if (!restaurant) {
        return res.status(404).json({ message: "Request not found" });
    }
    const ownerId = restaurant.Owner;

    if (restaurant.status !== "pending") {
        return res.status(400).json({ message: "This request has already been processed." });
    }

    if (action === "approve") {
        await updateRestaurantStatus(restaurant._id, "approved", AdminId);
        await Users.findByIdAndUpdate(restaurant.Owner, { role: "owner" });

        await notificationModel.create({
            sender: AdminId,
            message: `Your request has been approved and now you are Owner`,
            receiver: ownerId,
            type: "approved",
            restaurant: restaurant._id
        });

        return res.status(200).json({ message: "Restaurant accepted successfully" });

    } else if (action === "reject") {
        if (!reason || !reason.trim()) {
            return res.status(400).json({ message: "Please provide a reason for rejection" });
        }

        const settings = await getSettingsService();
        const maxRejectionLimit = settings.maxRejectionLimit;
        
        const currentRejectionCount = (restaurant.rejectionCount || 0) + 1;

        if (currentRejectionCount >= maxRejectionLimit) {
            await reviewModel.deleteMany({ restaurant: restaurantId });
            await favResModel.deleteMany({ restaurant: restaurantId });
            
            await restaurantModel.findByIdAndDelete(restaurantId);

            await notificationModel.create({
                sender: AdminId,
                message: `Your restaurant request has been permanently deleted after ${maxRejectionLimit} failed attempts.`,
                receiver: ownerId,
                type: "rejected"
            });

            return res.status(200).json({ 
                message: "Restaurant reached maximum rejection limit and has been deleted." 
            });
        }

        const updatedRestaurant = await updateRestaurantStatus(restaurant._id, "rejected", AdminId, reason);
        const remainCounts = maxRejectionLimit - updatedRestaurant.rejectionCount;

        await notificationModel.create({
            sender: AdminId,
            message: `Your request has been rejected because: ${reason}. You have ${remainCounts} attempts left.`,
            restaurant: restaurant._id,
            receiver: ownerId,
            type: "rejected"
        });

        return res.status(200).json({ 
            message: "Request rejected", 
            remainingAttempts: remainCounts,
            rejectionCount: updatedRestaurant.rejectionCount
        });
    }
});


export {
    getSystemSettings,
    updateSysSettings,
    getRestaurantRequests,
    getOneRequest,
    acceptRejectRequest
}; 