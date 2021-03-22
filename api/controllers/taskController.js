//TODO: Initiate Task controllers here

const { project, task } = require("../models/projectSchema");
const response = require("../utils/responseHandler");
const { uuid } = require("uuidv4");

async function createTask(req, res) {
  try {
    const projectID = req.body.projectID;
    const taskTitle = req.body.title.trim();
    const taskStage = 1;
    const attachments = [];
    const token = uuid();
    const taskID = uuid();
    const createdAt = new Date();
    const description = req.body.description.trim();

    const newTask = new task({
      taskID: taskID,
      taskTitle: taskTitle,
      taskStage: taskStage,
      attachments: attachments,
      token: token,
      description: description,
      createdAt: createdAt,
    });
    result = await project.updateOne(
      {
        projectID: projectID,
      },
      {
        $push: { tasks: newTask },
      }
    );
    if (!result) {
      return response.sendError(
        res,
        "Error occured while Adding task to the project"
      );
    }
    return response.sendResponse(res, "Added task successfully");
  } catch (error) {
    console.log(error);
    response.sendError(res, error);
  }
}
async function editTaskTitle(req, res) {
  try {
    const projectID = req.body.projectID;
    const taskID = req.body.taskID;
    const title = req.body.title.trim();

    result = await project.updateOne(
      {
        projectID: projectID,
        "tasks.taskID": taskID,
      },
      {
        $set: { "tasks.$.taskTitle": title },
      }
    );
    if (!result) {
      return response.sendError(
        res,
        "Error occured while editing task title of the project"
      );
    }
    return response.sendResponse(res, "Changed task title successfully");
  } catch (error) {
    console.log(error);
    response.sendError(res, error);
  }
}
async function editTaskDescription(req, res) {
  try {
    const projectID = req.body.projectID;
    const taskID = req.body.taskID;
    const description = req.body.description.trim();

    result = await project.updateOne(
      {
        projectID: projectID,
        "tasks.taskID": taskID,
      },
      {
        $set: { "tasks.$.description": description },
      }
    );
    if (!result) {
      return response.sendError(
        res,
        "Error occured while editing task description of the project"
      );
    }
    return response.sendResponse(res, "Changed task  description successfully");
  } catch (error) {
    console.log(error);
    response.sendError(res, error);
  }
}

async function addAttachmentToTask(req, res) {
  try { //TODO: ADD CODE TO UPLOAD ATTACHMENT TO TASK
  } catch (error) {
    console.log(error);
    response.sendError(res, error);
  }
}
module.exports = {
  createTask,
  editTaskTitle,
  editTaskDescription,
};
