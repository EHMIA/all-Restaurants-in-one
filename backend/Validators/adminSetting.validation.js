import joi from "joi";

const settingsValidation = (obj)=>{
    const schema = joi.object({
        lowMax: joi.number()
            .precision(2) 
            .min(0)
            .optional(),
        mediumMax: joi.number()
            .precision(2)
            .min(joi.ref('lowMax')) 
            .optional(),
        maxRejectionLimit: joi.number()
            .integer()
            .min(1)
            .optional()
    }).min(1);

    return schema.validate(obj);
};

export { settingsValidation };