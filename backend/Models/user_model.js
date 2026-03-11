const mongoose = require('mongoose')

const userschema =new mongoose.Schema({
    firstname :{
        type : String ,
        trim: true,
        require :true
    },
    lastname :{
        type : String ,
        trim: true,
        require :true
    },
    email :{
        type : String ,
        unique: true,
        trim: true,
        require :true
    },
    phone :{
        type : String ,
        trim: true,
        require :true
    },
    profile_pic :{
        type : String ,
        require :true,
        default:"default.png"
    },
    password :{
        type : String ,
        require :true
    },
    role :{
        type : String ,
        enum:['user','admin','restaurant_owner'],
        default:'user',
        require :true
    },
    address: [{
        governorate: {
            type: String,
            required: true,
            trim: true
        },
        city: {
            type: String,
            required: true,
            trim: true
        },
        street: {
            type: String,
            trim: true,
            required: true
        },
        details: {
            type: String,
            trim:true,
            default: ""
        },
    }],
    default:[]
},{timestamps:true})

const Users = mongoose.model('Users',userschema)

module.exports = {Users}
