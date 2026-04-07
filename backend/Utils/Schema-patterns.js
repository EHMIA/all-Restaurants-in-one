// Regex patterns and  error messages

const emailField =
    /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

const phoneNumberField =
    /^01[0125][0-9]{8}$/; // covers 010, 011, 012, 015

const facebookLinkField =
    /^(https?:\/\/)?(?:www\.)?(?:facebook\.com|fb\.com)\/[a-zA-Z0-9_\-.]+(?:\/\d+)?\/?$/i;

const hoursField =
    /^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/;

// Error messages
const invalidPhoneMsg = "Phone number must be Egyptian, 11 digits, starting with 010, 011, 012, or 015";
const invalidPhotoMsg = "Invalid photo URL format";
const invalidEmailMsg = "Invalid email format";

export  {
    emailField, phoneNumberField,
    facebookLinkField, hoursField,
    invalidPhoneMsg, invalidEmailMsg
};