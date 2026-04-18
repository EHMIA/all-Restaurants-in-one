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
    const { lowMax, mediumMax } = req.body;
    let settings_ = await Settings.findOne();

    if (!settings_) {
        
        settings_ = await Settings.create({ lowMax, mediumMax });
    } else {
        
        if (lowMax !== undefined) settings_.lowMax = lowMax;
        if (mediumMax !== undefined) settings_.mediumMax = mediumMax;        
        await settings_.save();
    }
    res.status(200).json({ settings: settings_ });
});

export {
    getSystemSettings,
    updateSysSettings
}; 