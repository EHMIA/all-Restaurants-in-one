import jwt from "jsonwebtoken"

function verifyToken(req,res,next){
    const authHeader=req.headers.authorization;
    if(!authHeader || !authHeader.startsWith("Bearer ")){
        res.status(401).json({message:"Token not Provided or it is Wrong"});
    }
    const Token=authHeader.split(' ')[1];
    if(Token){
        try {
            const Payload=jwt.verify(Token,process.env.JWT_SECRET);
            req.user=Payload;
            next();
        } catch (error) {
            res.status(401).json({message:"Invalid Token"});
        }
    }else{
        res.status(401).json({message:"No token Provided"});
    }
}

function restrictToAdmin(req,res,next){
    verifyToken(req,res,()=>{
        if(req.user.role==="admin")next();
        else res.status(403).json({message:"Only Admains have this access"});
    })
}
function restrictToAdminOrUser(req,res,next){
    verifyToken(req,res,()=>{
        const isOwner = req.user.id === req.params.id;
        if(isOwner || Payload.role==="admin")next();
        else res.status(403).json({message:"Forbidden , please just change in your data"})
    })
}




export{
    verifyToken,
    restrictToAdmin,
    restrictToAdminOrUser
}