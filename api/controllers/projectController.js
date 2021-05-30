const { project } = require('../models/projectSchema');
const { user } = require('../models/userSchema');
const response = require('../utils/responseHandler');
const { uuid } = require('uuidv4');

async function createProject(req, res) {
	try {
		const projectID = uuid();
		const createdBy = {
			name: req.session.name,
			userID: req.session.userID,
		};
		const deadline = new Date(req.body.date);
		const title = req.body.title.trim();
		const projectStatus = 'Active';
		const collaborators = [createdBy];
		const newProject = new project({
			projectID: projectID,
			createdBy: createdBy,
			deadline: deadline,
			title: title,
			tasks: [],
			projectStatus: projectStatus,
			collaborators: collaborators,
			token: uuid(),
		});

		result = await newProject.save();
		if (!result) {
			return response.sendError(
				res,
				'Error occured while storing the project'
			);
		}
		userResult = await user.updateOne(
			{
				userID: req.session.userID,
			},
			{
				$push: {
					projects: projectID,
				},
			}
		);
		if (!userResult) {
			return response.sendError(
				res,
				'Error occured while adding user to project'
			);
		}
		return response.sendResponse(res, result);
	} catch (error) {
		console.log(error);
		response.sendError(res, error);
	}
}
async function deleteProject(req, res) {
	try {
		const projectID = req.body.projectID.trim();
		result = await project.remove({
			projectID: projectID,
		});
		if (!result) {
			return response.sendError(
				res,
				'Error occured while deleting the project'
			);
		}
		return response.sendResponse(res, 'Project Deleted successfully');
	} catch (error) {
		console.log(error);
		response.sendError(res, error);
	}
}
async function editDeadline(req, res) {
	try {
		const projectID = req.body.projectID;
		const deadline = new Date(req.body.deadline);
		result = await project.updateOne(
			{
				projectID: projectID,
			},
			{
				$set: { deadline: deadline },
			}
		);
		if (!result) {
			return response.sendError(
				res,
				'Error occured while Updating deadline of the project'
			);
		}
		return response.sendResponse(res, 'Deadline changed successfully');
	} catch (error) {
		console.log(error);
		response.sendError(res, error);
	}
}
async function changeProjectTitle(req, res) {
	try {
		const projectID = req.body.projectID;
		const title = req.body.title.trim();
		result = await project.updateOne(
			{
				projectID: projectID,
			},
			{
				$set: { title: title },
			}
		);
		if (!result) {
			return response.sendError(
				res,
				'Error occured while Updating Title of the project'
			);
		}
		return response.sendResponse(res, 'Title changed successfully');
	} catch (error) {
		console.log(error);
		response.sendError(res, error);
	}
}
async function getUserProjects(req, res) {
	try {
		result = await user.findOne(
			{
				userID: req.session.userID,
			},
			{
				projects: 1,
			}
		);
		if (!result) {
			return response.sendError(
				res,
				'Error occured while fetching user projects'
			);
		}
		projectsObj = [];
		for (let i = 0; i < result.projects.length; i++) {
			proj = await project.findOne({
				projectID: result.projects[i],
			});
			if (!proj) {
				return response.sendError(
					res,
					'Error occured while fetching a project'
				);
			}
			obj = {
				title: proj.title,
				projectID: result.projects[i],
			};
			console.log(obj);
			projectsObj.push(obj);
		}
		return response.sendResponse(res, projectsObj);
	} catch (error) {
		console.log(error);
		response.sendError(res, error);
	}
}

module.exports = {
	createProject,
	deleteProject,
	editDeadline,
	changeProjectTitle,
	getUserProjects,
};
