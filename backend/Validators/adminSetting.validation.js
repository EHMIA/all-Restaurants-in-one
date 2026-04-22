import joi from "joi";

const settingsValidation = {
    body: joi.object({
        lowMax: joi.number()
            .precision(2) 
            .min(0)
            .optional(),
        mediumMax: joi.number()
            .precision(2)
            .min(joi.ref('lowMax')) 
            .optional()
    })
};

export { settingsValidation };