import { v2 as cloudinary } from "cloudinary";
import multer from "multer";
import { Readable } from "stream";

cloudinary.config({
    cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
    api_key: process.env.CLOUDINARY_CLOUD_API_KEY,
    api_secret: process.env.CLOUDINARY_CLOUD_API_SECRET_KEY
});

const upload = multer({ storage: multer.memoryStorage() });

const uploadToCloudinary = (buffer) => {
    return new Promise((resolve, reject) => {
        const stream = cloudinary.uploader.upload_stream(
            { folder: "Restaurant_Images" },
            (error, result) => {
                if (error) reject(error);
                else resolve({
                    url: result.secure_url,
                    publicId: result.public_id
                });
            }
        );
        Readable.from(buffer).pipe(stream).on('error', reject);
    });
};

export { upload, uploadToCloudinary };