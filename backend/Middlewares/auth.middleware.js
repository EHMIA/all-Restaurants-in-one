import jwt from "jsonwebtoken"
import  { Users } from "../Models/user.model.js"
import { restaurantModel } from "../Models/restaurant.model.js";

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

const restrictToAdminOrAccountOwner= (req,res,next)=>{
    if(!req.user){
        return res.status(401).json({message: "Please Login first"});
    }
    const isAccOwner= req.params.id && req.params.id=== req.user.id;

    if(isAccOwner || req.user.role=="admin"){
        return next();
    }
    return res.status(403).json({message:"You can Only modify your data"});
}


const restrictToAdmin= (req,res,next)=>{
    if(!req.user){
        return res.status(401).json({message: "Please Login first"});
    }

    if(req.user.role=="admin"){
        return next();
    }
    return res.status(403).json({message:"Only Admains have this access"});
}


const restrictToRestaurantOwner = async (req, res, next) => {
    if(!req.user){
        return res.status(401).json({message: "Please Login first"});
    }
    
    const restaurantId = req.params.id;
    try {
        // data will be used in specific end points
        const restaurant = await restaurantModel.findById(restaurantId).select("Owner Gallery coverPhoto menu");
        
        if (!restaurant) 
            return res.status(404).json({ message: "Restaurant not found" });

        const isOwner = restaurant.Owner.equals(req.user.id); 

        if (isOwner) {
            req.restaurant = restaurant; 
            return next();
        }
        return res.status(403).json({ message: "Only Restaurant Owner have this access" });
        
    } catch (error) {
        return res.status(500).json({ message: "Server Error", error: error.message });
    }
}

export{
    optionalProtect,
    Protect,
    restrictToAdminOrAccountOwner,
    restrictToAdmin,
    restrictToAccountOwner,
    restrictToRestaurantOwner
}