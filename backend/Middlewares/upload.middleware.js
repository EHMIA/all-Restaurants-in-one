import { upload } from "../Utils/cloudinary.js";
import { LIMITS } from "../Utils/Constants.js";

const uploadSingleImage=upload.single("image");

const uploadRestaurantData = upload.fields([
    { name: "coverImage", maxCount: 1 },
    { name: "Gallery", maxCount: LIMITS.GALLERY_PHOTOS },
]);

export{
    uploadSingleImage,
    uploadRestaurantData
}