const nodemailer = require('nodemailer');
const ses = require('nodemailer-ses-transport');
const aws = require('aws-sdk');
const response = require('../utils/responseHandler');

aws.config.loadFromPath('../awsconfig.json');

const transport = nodemailer.createTransport(
	ses({
		host: 'email-smtp.ap-south-1.amazonaws.com',
		port: 2525,
		auth: {
			user: process.env.USER,
			pass: process.env.PASS,
		},
	})
);

async function sendUserAuthOTP(res, userData) {
	try {
		const from = 'NextUp Admin <swadhin.routray@gmail.com>';
		const html = `Hello ${userData.name}
          <p>
             We hope you're having a good experience while using our application!    
          </p>
          <br>Here is your OTP to complete stage: <b>${userData.OTP}</b><br>
         
          <br>
          <p>
            Regards,<br> 
            NextUp: A PM Tool
          </p>`;
		const message = {
			from,
			to: userData.email.trim(),
			subject: 'Authentication OTP to Complete Stage',
			html,
		};
		await transport.sendMail(message, (err, info) => {
			if (err) {
				console.log(err);
				return response.sendError(
					res,
					'Error occured while sending Email for OTP'
				);
			} else {
				// console.log("Message sent" + info);
				return response.sendResponse(res, 'Sent OTP successfully');
			}
		});
	} catch (error) {
		console.log(error);
		response.sendError(res, error);
	}
}

async function sendCollaboratorMail(name, email) {
	try {
		const from = 'NextUp Admin <swadhin.routray@gmail.com>';
		const html = `Hello ${name}
          <p>
          You have been added to collaborate on a new project!    
          </p>
         
          <br>
          <p>
          <br>
            Regards,<br> 
            NextUp: A PM Tool
          </p>`;
		const message = {
			from,
			to: email,
			subject: 'You have been added as a collaborator!',
			html,
		};
		await transport.sendMail(message, (err, info) => {
			if (err) {
				throw err;
			} else {
				return;
			}
		});
	} catch (error) {
		console.log(error);
	}
}
module.exports = {
	sendUserAuthOTP,
	sendCollaboratorMail,
};
