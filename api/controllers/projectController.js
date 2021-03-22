const { project } = require("../models/projectSchema");
const response = require("../utils/responseHandler");
const { uuid } = require("uuidv4");

async function createProject(req, res) {
  try {
    const projectID = uuid();
    const createdBy = {
      name: req.session.name,
      userID: req.session.userID,
    };
    const deadline = new Date(req.body.date);
    const title = req.body.title.trim();
    const projectStatus = "Active";
    const collaborators = [createdBy];
    const newProject = new project({
      projectID: projectID,
      createdBy: createdBy,
      deadline: deadline,
      title: title,
      tasks: [],
      projectStatus: projectStatus,
      collaborators: collaborators,
    });

    result = await newProject.save();
    if (!result) {
      return response.sendError(res, "Error occured while storing the project");
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
        "Error occured while deleting the project"
      );
    }
    return response.sendResponse(res, "Project Deleted successfully");
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
        "Error occured while Updating deadline of the project"
      );
    }
    return response.sendResponse(res, "Deadline changed successfully");
  } catch (error) {
    console.log(error);
    response.sendError(res, error);
  }
}
async function changeProjectTitle(req,res){
    try {
        const projectID = req.body.projectID;
        const title = req.body.title.trim()
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
            "Error occured while Updating Title of the project"
          );
        }
        return response.sendResponse(res, "Title changed successfully");   
    } catch (error) {
        console.log(error);
        response.sendError(res, error);
    }
}
module.exports = {
  createProject,
  deleteProject,
  editDeadline,
  changeProjectTitle
};
