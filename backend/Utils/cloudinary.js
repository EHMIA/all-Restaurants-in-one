import { v2 as cloudinary } from "cloudinary";
import { CloudinaryStorage } from "multer-storage-cloudinary";
import multer from "multer";

cloudinary.config({
    cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
    api_key: process.env.CLOUDINARY_API_KEY,
    api_secret: process.env.CLOUDINARY_API_SECRET
});

const Storage = new CloudinaryStorage({
    cloudinary: cloudinary,
    params: {
        folder: "Restaurant_Images",
        allowed_formats: ["jpeg", "png", "jpg", "webp", "svg"]
    }
});

const upload = multer({ storage: Storage });

export { upload, cloudinary };