import { upload } from "../Utils/cloudinary.util.js";
import { LIMITS } from "../Utils/Constants.util.js";

const uploadSingleImage = upload.single("image");

const uploadMultipleImages = upload.array("images", 10);

export { uploadSingleImage, uploadMultipleImages };
