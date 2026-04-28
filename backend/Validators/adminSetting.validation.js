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

const validateRequest= (obj)=>{
    const schema = joi.object({
        action: joi.string().valid("approve", "reject").required(),
        reason: joi.string().allow("").optional().when('action', {
            is: 'approve',
            then: joi.forbidden(), 
            otherwise: joi.optional() 
        }),
    })
    .messages({
        "any.unknown": "Reason is not allowed when approving"
    });
    return schema.validate(obj);
}
export { settingsValidation, validateRequest };