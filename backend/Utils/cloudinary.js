import {v2 as cloudinary} from "cloudinary";

cloudinary.config({
    cloude_name:process.env.CLOUDINARY_CLOUD_NAME,
    api_key:process.env.CLOUDINARY_API_KEY,
    api_secret:process.env.CLOUDINARY_API_SECRET
});
const Storage=new CloudinaryStorage({
    storage:cloudinary,
    params:{
        folder:"Restaurant_Images",
        allowed_formats:["jpeg","png","jpg","webp","svg"]
    }
})

const upload = multer({Storage});
export{
    upload,
    cloudinary
} 
