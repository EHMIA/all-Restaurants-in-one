import asyncHandler from "express-async-handler"
import { deleteAllMsgService, deleteOneMsgService, getMyNotificationsService, getOneMsgService } from "../Services/notificaions.service.js"

const getMyNotifications = asyncHandler(async(req,res)=>{
    const notifications=await getMyNotificationsService(req.user);
    if(!notifications)
        return res.status(200).json({message:"No notifications found",
        Data:[]
    });
    
    return res.status(200).json({
        message:"Notifications retrieved successfully",
        Data:notifications
    });
})

const getOneNotification = asyncHandler(async (req, res) => {
    const notification = await getOneMsgService(req.params.id, req.user.id);
    if (!notification) {
        return res.status(200).json({ 
            message: "No notification found",
            Data: [] 
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
        return res.status(500).json({message:"Failed to delete notification"});
    res.status(200).json({message:"Notification deleted successfully"});
})

const deleteAllMsg=asyncHandler(async(req,res)=>{
    const notifications=await deleteAllMsgService(req.user.id);
    if(!notifications)
        return res.status(200).json({message:"You have no notifications"});
    res.status(200).json({message:"All Notifications deleted"});
})


export{
    getMyNotifications,
    getOneNotification,
    deleteOneMsg,
    deleteAllMsg,
}