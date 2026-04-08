import jwt from "jsonwebtoken"
import  { Users } from "../Models/user.model.js"

const optionalProtect= async(req,res,next)=>{
    const authHeader= req.headers.authorization;

    if(!authHeader || !authHeader.startsWith("Bearer ")){
        req.user=null;
        return next();
    }
    const token = authHeader.split(" ")[1];
    try {
        const decoded= jwt.verify(token, process.env.JWT_SECRET);
        const user= await Users.findById(decoded.id).select("_id role");
        
        req.user= user || null;
        next();
    } catch (error) {
        req.user=null;
        next();
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

// const restrictToRestaurantOwner= (req,res,next)=>{
//     if(!req.user){
//         return res.status(401).json({message: "Please Login first"});
//     }
//     if(req.user.role==="admin"){
//         return next();
//     }
// }

export{
    optionalProtect,
    Protect,
    restrictToAdminOrAccountOwner,
    restrictToAdmin
}