mongoose  	= require 'mongoose'

# Defining MongoDB Schema / Model for Messages
MessageSchema = mongoose.Schema
    name: String

Message = mongoose.model 'Message', MessageSchema


module.exports = Message