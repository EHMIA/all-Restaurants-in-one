import { notificationModel } from "../Models/notifications.model.js";

const getMyNotificationsService = async (receiverId) => {
    const notifications = await notificationModel.find({ receiver: receiverId })
        .sort({ createdAt: -1 }) 
        .select("message type isRead createdAt")
        .populate("restaurant", "_id name coverPhoto rejectionCount"); 
    return notifications.length > 0 ? notifications : null;
}

const getOneMsgService = async (notificationId, userId) => {
    const notification = await notificationModel.findOneAndUpdate(
        { _id: notificationId, receiver: userId }, 
        { isRead: true },
        { new: true }
    )
    .select("message type isRead   createdAt") 
    .populate("restaurant", "_id name coverPhoto rejectionCount"); 
    return notification;
}


const deleteOneMsgService=async(notificationId,receiverId)=>{
    const notification=await notificationModel.
    findOneAndDelete({
        _id: notificationId, 
        receiver: receiverId 
    });
    if (!notification) return null;
    return notification;
}

const deleteAllMsgService=async(receiverId)=>{
    const notifications=await notificationModel.deleteMany({receiver:receiverId});
    if (notifications.deletedCount===0) return null;
    return notifications;
}

const markAsReadService = async (notificationId, receiverId) => {
    const notification = await notificationModel.findOneAndUpdate(
        { 
            _id: notificationId, 
            receiver: receiverId 
        }, 
        { 
            $set: { isRead: true } 
        },
        { 
            new: true, 
            runValidators: true 
        }
    );

    if (!notification) return null;
    return notification;
}

const markAllAsReadService = async (receiverId) => {
    return await notificationModel.updateMany(
        { receiver: receiverId, isRead: false },
        { $set: { isRead: true } }
    );
}

export {
    getMyNotificationsService,
    getOneMsgService,
    deleteOneMsgService,
    deleteAllMsgService,
    markAsReadService,
    markAllAsReadService
}