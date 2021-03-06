const bcrypt = require('bcryptjs');
const { user } = require('../models/userSchema');
const { uuid } = require('uuidv4');
const response = require('../utils/responseHandler');

async function Register(req, res) {
	try {
		console.log(req.body);
		const salt = await bcrypt.genSalt(parseInt(process.env.SALT_FACTOR));
		bcrypt.hash(req.body.password, salt).then(async (hash) => {
			const newUser = new user({
				userID: uuid(),
				name: req.body.name.trim(),
				email: req.body.email.trim(),
				password: hash,
				contact: req.body.contact.trim(),
				projects: [],
			});

			var result = await newUser.save();
			if (!result) {
				console.log(e);
				return response.sendError(res, 'An error Occured');
			}

			return response.sendResponse(res, newUser);
		});
	} catch (e) {
		console.log(e);
		return response.sendError(res, e);
	}
}
async function Login(req, res) {
	try {
		// console.log(req.session)
		if (req.session.logged_in == undefined || !req.session.logged_in) {
			result = await user.findOne({ email: req.body.email.trim() });
			// console.log(result)

			if (!result) return response.sendError(res, 'Invalid Credentials');
			else if (result.length == 0)
				return response.sendError(res, 'Invalid Credentials');
			else {
				resultVal = await bcrypt.compare(
					req.body.password,
					result.password
				);

				if (!resultVal)
					return response.sendError(res, 'Wrong Password');
				else {
					//console.log(query);
					req.session.email = req.body.email;
					req.session.name = result.name;
					req.session.logged_in = true;
					req.session.userID = result.userID;
					// console.log(req.session)
					console.log(req.session);
					req.session.save(() => {
						return response.sendResponse(res, result);
					});
				}
			}
		} else {
			console.log(req.session);
			return response.sendError(res, 'Already Logged In');
		}
	} catch (e) {
		console.log(e);
		return response.sendError(res, 'An error Occured ' + e);
	}
}

async function Logout(req, res) {
	console.log(req.session);

	await req.session.destroy();
	console.log(req.session);
	return response.sendResponse(res, 'Logged Out Successfully');
}

async function init(req, res) {
	try {
		if (req.session.logged_in) {
			const userID = req.session.userID;
			result = await user.find({
				userID: userID,
			});
			if (!result)
				return res.send({
					success: true,
					data: { error: 'Could not retreive user' },
				});
			console.log(result[0]);
			obj = result[0];
			return res.send({
				success: true,
				data: { logged_in: true, user: obj },
			});
		} else {
			return res.send({
				success: true,
				data: { logged_in: false },
			});
		}
	} catch (error) {
		console.log(req.session);
		return res.send({ success: true, data: 'Could not initialise user' });
	}
}
module.exports = { Register, Login, Logout, init };
