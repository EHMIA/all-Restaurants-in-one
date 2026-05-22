// import asyncHandler from "express-async-handler";
// import {nodemailer} from "nodemailer";


// const transporter = createTransport({
//     service: 'Gmail',
//     auth: { 
//         user: process.env.EMAIL,
//         pass: process.env.EMAIL_PASSWORD
//     },
//     tls: {
//         rejectUnauthorized: false
//     }
// });

// const contactUs = asyncHandler(async (req, res) => {
//     const {name, email, message} = req.body;  
    
//     if (!name || !email || !message) {
//         return res.status(400).json({ message: 'All fields are required' });
//     }
//     const mailOptions = {
//         from: email, 
//         to: process.env.EMAIL, // Your email address to receive the contact messages
//         subject: `Contact Us Message from ${name}`,
//         text: message
//     };
//     await transporter.sendMail(mailOptions);
//     res.status(200).json({  message: 'Message sent successfully' });
// });

// export {contactUs};


import asyncHandler from "express-async-handler";
import nodemailer from "nodemailer"; 
import { contactUsSchema } from "../Validators/contact_us_validation.js";

const transporter = nodemailer.createTransport({
    service: 'Gmail',
    auth: { 
        user: process.env.EMAIL,
        pass: process.env.EMAIL_PASSWORD
    },
    tls: {
        rejectUnauthorized: false
    }
});

const contactUs = asyncHandler(async (req, res) => {
    const {name, email, message} = req.body;  
    
    if (!name || !email || !message) {
        return res.status(400).json({ message: 'All fields are required' });
    }

    const { massage } = contactUsSchema.validate({ name, email, message });
    if (massage) {
        return res.status(400).json({ message: massage.details[0].message });
    }

    const mailOptions = {
        from: `${name} <${process.env.EMAIL}>`, 
        replyTo: email,
        to: process.env.EMAIL, 
        subject: `Contact Us Message from ${name}`,
        text: message
    };
    
    await transporter.sendMail(mailOptions);
    res.status(200).json({ message: 'Message sent successfully' });
});

export { contactUs };