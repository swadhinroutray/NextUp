const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
	userID: {
		type: String,
	},
	name: {
		type: String,
		required: true,
	},
	email: {
		type: String,
		required: true,
		unique: true,
	},
	password: {
		type: String,
		required: true,
	},
	contact: {
		// Phone numner
		type: String,
		required: true,
	},
	projects: {
		//! Store Project title and ID
		type: Array,
	},
	token: {
		//! For Forgot Password Purposes
		type: String,
	},
	deviceID: {
		type: String, //! For push notifications
	},
});

const user = mongoose.model('user', userSchema);
module.exports = {
	user,
};
