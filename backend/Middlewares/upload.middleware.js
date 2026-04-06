import { upload } from "../Utils/cloudinary.js";
import { LIMITS } from "../Utils/Constants.js";

const uploadSingleImage=upload.single("image");

const uploadRestaurantData = upload.fields([
    { name: "coverImage", maxCount: 1 },
    { name: "gallery", maxCount: LIMITS.GALLERY_PHOTOS , minCount:4},
    { name: "menuImages", maxCount: LIMITS.MENU_ITEMS },
]);

export{
    uploadSingleImage,
    uploadRestaurantData
}