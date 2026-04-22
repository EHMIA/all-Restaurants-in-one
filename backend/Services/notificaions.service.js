import { notificationModel } from "../Models/notifications.model.js";

const getMyNotificationsService = async(receiverId)=>{
    const notifications=await notificationModel.find({receiver:receiverId});
    if (notifications.length===0) return null;
    return notifications;
}

const getOneMsgService=async(notificationId)=>{
    const notification = await notificationModel.
                                findById(notificationId).
                                populate("sender", "name email profile_pic").
                                populate("restaurant");
    if (!notification) return null;
    return notification;
}


const deleteOneMsgService=async(notificationId)=>{
    const notification=await notificationModel.findByIdAndDelete(notificationId);
    if (!notification) return null;
    return notification;
}

const deleteAllMsgService=async(receiverId)=>{
    const notifications=await notificationModel.deleteMany({receiver:receiverId});
    if (notifications.deletedCount===0) return null;
    return notifications;
}
export {
    getMyNotificationsService,
    getOneMsgService,
    deleteOneMsgService,
    deleteAllMsgService
}