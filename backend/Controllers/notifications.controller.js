import {asyncHandler} from "express-async-handler"
import { deleteAllMsgService, deleteOneMsgService, getMyNotificationsService, getOneMsgService, markAsReadService } from "../Services/notificaions.service.js"

const getMyNotifications = asyncHandler(async(req,res)=>{
    const notifications=await getMyNotificationsService(req.user);
    if(!notifications)
        return res.status(404).json({message:"No notifications found"});
    
    return res.status(200).json({
        message:"Notifications retrieved successfully",
        Data:notifications
    });
})

const getOneNotification = asyncHandler(async (req, res) => {
    const notification = await getOneMsgService(req.params.id, req.user.id);
    if (!notification) {
        return res.status(404).json({ 
            message: "Notification not found or you don't have permission" 
        });
    }
    res.status(200).json({
        message: "Notification retrieved successfully",
        Data: notification
    });
});


const deleteOneMsg=asyncHandler(async(req,res)=>{
    const notification=await deleteOneMsgService(req.params.id, req.user.id);
    if(!notification)
        return res.status(404).json({message:"No notification found"});
    res.status(200).json({message:"Notification deleted"});
})

const deleteAllMsg=asyncHandler(async(req,res)=>{
    const notifications=await deleteAllMsgService(req.user.id);
    if(!notifications)
        return res.status(404).json({message:"No notifications found"});
    res.status(200).json({message:"All Notifications deleted"});
})

const maskAsRead=asyncHandler(async(req,res)=>{
    const notification=await markAsReadService(req.params.id, req.user.id);
    if(!notification)
        return res.status(404).json({message:"Notification not found"});
    res.status(200).json({message:"Notification marked as read"});
})

const maskAllAsRead= asyncHandler(async(req,res)=>{
    const notifications=await markAllAsReadService(req.user.id);
    if(!notifications)
        return res.status(404).json({message:"Notifications not found"});
    res.status(200).json({message:"All Notifications marked as read"});
})

const 
export{
    getMyNotifications,
    getOneNotification,
    deleteOneMsg,
    deleteAllMsg,
    maskAsRead
}