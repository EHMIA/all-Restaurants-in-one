import { Users } from "../Models/user.model.js";
import asyncHandler from "express-async-handler";

const uploadPhoto = asyncHandler(async (req, res) => {
    if (!req.file) {
        return res.status(400).json({ error: "No file uploaded" });
    }   
    const user = await Users.findById(req.user.id);
    if (!user) {
        return res.status(404).json({ error: "User not found" });
    }
    user.photo = req.file.path;
    await user.save();
    res.status(200).json({ message: "Photo uploaded successfully", photoPath: req.file.path });
});

export { uploadPhoto };