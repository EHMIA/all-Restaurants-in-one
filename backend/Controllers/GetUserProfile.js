import { Users } from '../Models/user.model.js';
import asyncHandler from "express-async-handler";


const getUserProfile = asyncHandler(async (req ,res) => {

    const user = await Users.findOne({ _id: req.user.id }).select('-password');
    // const user = await Users.findOne({ _id: req.user.id }).select('-password');

    if (!user) {
        return res.status(404).json({ error: 'User not found' });
    }   
    
    res.status(200).json({
        message: 'User profile retrieved successfully',
        user
    });


});

export { getUserProfile };