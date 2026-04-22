import asyncHandler from "express-async-handler"
import { Settings } from "../Models/adminSettings.model.js"
import { settingsValidation } from "../Validators/adminSetting.validation.js";
import { addRecalculatePricesJob } from "../Jobs/restaurantQueue.job.js";

const getSystemSettings = asyncHandler(async (req, res) => {
    let settings_ = await Settings.findOne();
    if (!settings_) {
        settings_ = await Settings.create({}); 
    }
    res.status(200).json({ settings: settings_ });
});

const updateSysSettings = asyncHandler(async (req, res) => {
    const {error}= settingsValidation(req.body);
    if(error)
        return res.status(400).json({message:error.details[0].message});

    const { lowMax, mediumMax } = req.body;
    let settings_ = await Settings.findOne();

    if (!settings_) {
        settings_ = await Settings.create({ lowMax, mediumMax });
    } else {
        if (lowMax !== undefined) settings_.lowMax = lowMax;
        if (mediumMax !== undefined) settings_.mediumMax = mediumMax;        
        await settings_.save();
    }

    await addRecalculatePricesJob({ 
        lowMax: settings_.lowMax, 
        mediumMax: settings_.mediumMax 
    });

    res.status(200).json({ 
        message: "Settings updated and background recalculation started.",
        settings: settings_ 
    });
});

export {
    getSystemSettings,
    updateSysSettings
}; 