import asyncHandler from "express-async-handler";
import { Users } from "../Models/user.model.js";
import { uploadToCloudinary } from "../Utils/cloudinary.util.js";

const uploadProfilePicController = asyncHandler(async (req, res) => {
  if (!req.file) {
    return res.status(400).json({ message: "Please upload an image" });
  }

  const imageUrl = await uploadToCloudinary(req.file.buffer);

  const updatedUser = await Users.findByIdAndUpdate(
    req.user.id,
    { profile_pic: imageUrl },
    { new: true, runValidators: true },
  );

  if (!updatedUser) {
    return res.status(404).json({ message: "User not found" });
  }

  res.status(200).json({
    message: "Profile picture updated successfully",
    profile_pic: updatedUser.profile_pic,
  });
});

export { uploadProfilePicController };
