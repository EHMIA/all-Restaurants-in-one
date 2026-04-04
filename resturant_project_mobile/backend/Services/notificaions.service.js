import { notificationModel } from "../Models/notifications.model";

const getMyNotificationsService = async(receiverId)=>{
    const notifications=await notificationModel.find({receiver:receiverId});
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

const markAsReadService=async(notificationId)=>{
    const notification=await notificationModel.findById(notificationId);
    if (!notification) return null;
    notification.isRead=true;
    await notification.save();
    return notification;
}


const maskAllAsReadService=async(receiverId)=>{
    const notifications=await notificationModel.find({receiver:receiverId});
    if (!notifications) return null;
    notifications.forEach((notification)=>{
        notification.isRead=true;
        notification.save();
    })
    return notifications;
}

const deleteOneMsgService=async(notificationId)=>{
    const notification=await notificationModel.findByIdAndDelete(notificationId);
    if (!notification) return null;
    return notification;
}

const deleteAllMsgService=async(receiverId)=>{
    const notifications=await notificationModel.deleteMany({receiver:receiverId});
    if (!notifications) return null;
    return notifications;
}
export {
    getMyNotificationsService,
    getOneMsgService,
    markAsReadService,
    maskAllAsReadService,
    deleteOneMsgService,
    deleteAllMsgService
}