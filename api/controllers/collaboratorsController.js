const { project } = require('../models/projectSchema');
const { user } = require('../models/userSchema');
const response = require('../utils/responseHandler');
const mailer = require('../mailer/mailer');
async function addCollaboratorToProject(req, res) {
	try {
		const projectID = req.body.projectID;
		const collabEmail = req.body.email;

		checkEmail = await user.findOne({
			email: collabEmail,
		});
		if (!checkEmail) {
			return response.sendError(res, 'No such user exists!');
		}

		pushProject = await user.updateOne(
			{
				email: collabEmail,
			},
			{
				$push: {
					projects: projectID,
				},
			}
		);
		if (!pushProject) {
			return response.sendError(res, 'Push project error');
		}
		const collaboratorObj = {
			name: checkEmail.name,
			userID: checkEmail.userID,
		};
		updateProjectCollaborator = await project.updateOne(
			{
				projectID: projectID,
			},
			{
				$push: {
					collaborators: collaboratorObj,
				},
			}
		);
		if (!updateProjectCollaborator) {
			return response.sendError(res, 'Push collaborator error');
		}

		await mailer.sendCollaboratorMail(checkEmail.name, collabEmail);
		return response.sendResponse(res, 'User Invited Successfully');
	} catch (error) {
		console.log(error);
		response.sendError(res, error);
	}
}

async function removeCollaboratorFromProject(req, res) {
	try {
		const projectID = req.body.projectID;
		const userID = req.body.userID;

		projectRemove = await project.updateOne(
			{
				projectID: projectID,
			},
			{
				$pull: {
					collaborators: { userID: userID },
				},
			}
		);
		if (!projectRemove) {
			return response.sendError(res, 'Remove Collaborator Error');
		}

		userRemove = await user.updateOne(
			{
				userID: userID,
			},
			{
				$pull: {
					projects: projectID,
				},
			}
		);
		if (!userRemove) {
			return response.sendError(res, 'Remove Collaborator Error');
		}

		return response.sendResponse(res, 'User Removed Successfully');
	} catch (error) {
		console.log(error);
		response.sendError(res, error);
	}
}
async function getCollaborators(req, res) {
	try {
		const projectID = req.body.projectID;
		collaborators = await project.findOne(
			{
				projectID: projectID,
			},
			{
				collaborators: 1,
			}
		);
		if (!collaborators) {
			return response.sendError(res, 'Error fetching Collaborators');
		}
		return response.sendResponse(res, collaborators);
	} catch (error) {
		console.log(error);
		response.sendError(res, error);
	}
}
module.exports = {
	addCollaboratorToProject,
	removeCollaboratorFromProject,
	getCollaborators,
};
