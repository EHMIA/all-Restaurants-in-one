import asyncHandler from "express-async-handler"
import { Settings } from "../Models/adminSettings.model.js"

const getSystemSettings = asyncHandler(async (req, res) => {
    let settings_ = await Settings.findOne();
    if (!settings_) {
        
        settings_ = await Settings.create({}); 
    }
    res.status(200).json({ settings: settings_ });
});

const updateSysSettings = asyncHandler(async (req, res) => {
    const { lowMax, mediumMax, highMax } = req.body;
    let settings_ = await Settings.findOne();

    if (!settings_) {
        
        settings_ = await Settings.create({ lowMax, mediumMax, highMax });
    } else {
        
        if (lowMax !== undefined) settings_.lowMax = lowMax;
        if (mediumMax !== undefined) settings_.mediumMax = mediumMax;
        if (highMax !== undefined) settings_.highMax = highMax;
        
        await settings_.save();
    }
    res.status(200).json({ settings: settings_ });
});

export {
    getSystemSettings,
    updateSysSettings
}; 