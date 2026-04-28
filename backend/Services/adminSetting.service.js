import { Settings } from "../Models/adminSettings.model.js";

const getSettingsService= async () => {
    let settings_ = await Settings.findOne();
        if (!settings_) {
            settings_ = await Settings.create({}); 
        }
    return settings_;
}


export{
    getSettingsService
}