import jwt from "jsonwebtoken"
import  { Users } from "../Models/user.model.js"
import { restaurantModel } from "../Models/restaurant.model.js";
import mongoose from "mongoose";

const optionalProtect= async(req,res,next)=>{
    const authHeader= req.headers.authorization;

    if(!authHeader){
        req.user=null;
        return next();
    }

    if(authHeader && !authHeader.startsWith("Bearer ")){
        return res.status(401).json({message: "Invalid token format"});
    }

    const token = authHeader.split(" ")[1];
    try {
        const decoded= jwt.verify(token, process.env.JWT_SECRET);
        const user= await Users.findById(decoded.id).select("_id role");
                
        if (!user) {
            return res.status(401).json({ message: "User no longer exists" });
        }

        req.user= user;
        next();
    } catch (error) {
        return res.status(401).json({message: "Invalid or expired token"})
    }
}

// token required
const Protect = async(req,res,next)=>{
    const authHeader= req.headers.authorization;

    if(!authHeader || !authHeader.startsWith("Bearer ")){
        return res.status(401).json({message: "Token not provided"})
    }

    const token = authHeader.split(" ")[1];
    try {
        const decoded= jwt.verify(token, process.env.JWT_SECRET);
        const user= await Users.findById(decoded.id).select("_id role");
        
        if(!user){
            return res.status(401).json({message:"User not found"});
        }
        req.user=user;
        next();
    } catch (error) {
                return res.status(401).json({message: "Invalid or expired token"})
    }
}

const restrictToAccountOwner= (req,res,next)=>{
    if(!req.user){
        return res.status(401).json({message: "Please Login first"});
    }
    if(req.user.role==="user"){
        return next();
    }
    return res.status(403).json({message:"Only users have this access"});
}


const restrictToAdminOrAccountOwner = (req, res, next) => {
    if (!req.user) {
        return res.status(401).json({ message: "Please Login first" });
    }

    const isAccOwner = req.params.id && req.params.id.toString() === req.user._id.toString();

    if (req.user.role === "admin" || isAccOwner) {
        return next();
    }

    return res.status(403).json({ message: "You can Only modify your data" });
}

// const restrictToAdminOrAccountOwner= (req,res,next)=>{
//     if(!req.user){
//         return res.status(401).json({message: "Please Login first"});
//     }
//     const isAccOwner= req.params.id && req.params.id=== req.user.id;

//     if(isAccOwner || req.user.role=="admin"){
//         return next();
//     }
//     return res.status(403).json({message:"You can Only modify your data"});
// }


const restrictToAdmin= (req,res,next)=>{
    if(!req.user){
        return res.status(401).json({message: "Please Login first"});
    }

    if(req.user.role=="admin"){
        return next();
    }
    return res.status(403).json({message:"Only Admains have this access"});
}


const restrictToRestaurantOwnerPublic = async (req, res, next) => {
        const restaurantId = new mongoose.Types.ObjectId(req.params.restaurantId);
    const restaurant = await restaurantModel.findById(restaurantId)
        .select("_id status Owner Gallery coverPhoto menu rejectionCount");

    if (!restaurant) 
        return res.status(404).json({ message: "Restaurant not found" });
        
    if (!restaurant.Owner.equals(req.user.id)) {
        return res.status(403).json({ message: "Only Restaurant Owner has access" });
    }
    req.restaurant = restaurant;
    next();
}
const restrictToRestaurantOwner = async (req, res, next) => {
    const restaurant= req.restaurant;
    if (restaurant.status === "pending") {
        return res.status(400).json({ message: "Cannot edit while request is pending review." });
    }
    
    req.restaurant = restaurant;
    next();
};


const isApprovedOwner = (req, res, next) => {
    const restaurant = req.restaurant; 

    if (restaurant.status !== "approved") {
        return res.status(403).json({ 
            message: "Access denied. Your restaurant must be approved to manage Menu or Gallery." 
        });
    }
    next();
};

export{
    optionalProtect,
    Protect,
    restrictToAdminOrAccountOwner,
    restrictToAdmin,
    restrictToAccountOwner,
    restrictToRestaurantOwner,
    isApprovedOwner,
    restrictToRestaurantOwnerPublic
}