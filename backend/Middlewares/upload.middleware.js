import { upload } from "../Utils/cloudinary.js";
import { LIMITS } from "../Utils/Constants.js";

const uploadSingleImage=upload.single("image");

const uploadMultipleImages= upload.array("images",10);

export{
    uploadSingleImage,
    uploadMultipleImages
}