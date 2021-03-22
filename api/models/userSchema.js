const mongoose = require('mongoose')

const user  = new mongoose.Schema({
    userID:{
        type:String
    },
    name :{
        type: String,
        required: true,
    },
    email:{
        type:String,
        required:true,
        unique:true
    },
    password:{
        type:String,
        required:true
    },
    contact:{ // Phone numner 
        type: String,
        required: true
    }, 
    projects:{//! Store Project title and ID
        type:Array,
    } 
});

module.exports = mongoose.model("user",user)