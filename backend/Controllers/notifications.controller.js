import {asyncHandler} from "express-async-handler"
import { deleteAllMsgService, deleteOneMsgService, getMyNotificationsService, getOneMsgService, markAsReadService, maskAllAsReadService } from "../Services/notificaions.service"

const getMyNotifications = asyncHandler(async(req,res)=>{
    const notifications=await getMyNotificationsService(req.user.id);
    if(notifications.length===0)
        return res.status(404).json({message:"No notifications found"});
    res.status(200).json(notifications);
})

const getOneNotification=asyncHandler(async(req,res)=>{
    const notification=await getOneMsgService(req.params.id);
    if(!notification)
        return res.status(404).json({message:"No notification found"});
    res.status(200).json(notification);
})

const maskAsRead=asyncHandler(async(req,res)=>{
    const notification=await markAsReadService(req.params.id);
    if(!notification)
        return res.status(404).json({message:"Notification not found"});
    res.status(200).json({message:"Notification marked as read"});
})

const maskAllAsRead= asyncHandler(async(req,res)=>{
    const notifications=await maskAllAsReadService(req.user.id);
    if(!notifications)
        return res.status(404).json({message:"Notifications not found"});
    res.status(200).json({message:"All Notifications marked as read"});
})


const deleteOneMsg=asyncHandler(async(req,res)=>{
    const notification=await deleteOneMsgService(req.params.id);
    if(!notification)
        return res.status(404).json({message:"No notification found"});
    res.status(200).json({message:"Notification deleted"});
})

const deleteAllMsg=asyncHandler(async(req,res)=>{
    const notifications=await deleteAllMsgService(req.params.id);
    if(!notifications)
        return res.status(404).json({message:"No notifications found"});
    res.status(200).json({message:"All Notifications deleted"});
})

export{
    getMyNotifications,
    getOneNotification,
    maskAsRead,
    maskAllAsRead,
    deleteOneMsg,
    deleteAllMsg,
    
}