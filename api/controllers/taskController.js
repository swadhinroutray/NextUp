//TODO: Initiate Task controllers here

const { project, task } = require("../models/projectSchema");
const response = require("../utils/responseHandler");
const { uuid } = require("uuidv4");
const aws = require("../utils/aws");
const rand = require("randomatic");
const mailer = require("../mailer/mailer");
async function createTask(req, res) {
  try {
    const projectID = req.body.projectID;
    const taskTitle = req.body.title.trim();
    const taskStage = 1;
    const attachments = [];
    const token = rand("0", process.env.OTP_LENGTH);
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
  try {
    const projectID = req.body.projectID;
    const taskID = req.body.taskID;
    const files = req.files;
    const file = files[0];
    try {
      await aws.uploadS3(file, file.originalname);
      url =
        "https://" +
        process.env.BUCKET_NAME +
        ".s3.amazonaws.com/" +
        file.originalname;
    } catch (error) {
      console.log(error);
      if (!result) {
        return response.sendError(res, "");
      }
    }
    var date = new Date();
    const newAttachment = {
      attachmentID: uuid(),
      link: url,
      date: date,
      filename: file.originalname,
    };
    result = await project.updateOne(
      {
        projectID: projectID,
        "tasks.taskID": taskID,
      },
      { $push: { "tasks.$.attachments": newAttachment } }
    );
    if (!result) {
      return response.sendError(
        res,
        "Error occured while addding attachment to task"
      );
    }

    return response.sendResponse(res, "Added attachment successfully");
  } catch (error) {
    console.log(error);
    response.sendError(res, error);
  }
}
async function deleteAttachmentFromTask(req, res) {
  try {
    const projectID = req.body.projectID;
    const taskID = req.body.taskID;
    const attachmentID = req.body.attachmentID;
    const filename = req.body.filename.trim();
    try {
      await aws.deleteS3(filename);
    } catch (error) {
      console.log(error);
      return response.sendError(
        res,
        "Error occured while deleting attachment from task"
      );
    }
    result = await project.updateOne(
      {
        projectID: projectID,
        "tasks.taskID": taskID,
      },
      {
        $pull: {
          "tasks.$.attachments": { attachmentID: attachmentID },
        },
      }
    );
    if (!result) {
      return response.sendError(
        res,
        "Error occured while Deleting attachment from task"
      );
    }
    return response.sendResponse(res, "Deleted attachment successfully");
  } catch (error) {
    console.log(error);
    response.sendError(res, error);
  }
}

async function completeStageInitiation(req, res) {
  try {
    const name = req.session.name.trim();
    const email = req.session.email.trim();
    const taskID = req.body.taskID;
    const projectID = req.body.projectID;

    result = await project.findOne(
      {
        "tasks.taskID": taskID,
      },
      {
        tasks: 1,
      }
    );
    if (!result) {
      return response.sendError(res, "Error occured while fetching task");
    }
    let obj;
    // console.log(result.tasks[0]);
    for (let index = 0; index < result.tasks.length; index++) {
      if (result.tasks[index].taskID == taskID) {
        obj = result.tasks[index];
      }
    }
    userData = {
      name: name,
      email: email,
      OTP: obj.token,
    };
    await mailer.sendUserAuthOTP(res, userData);
  } catch (error) {
    console.log(error);
    response.sendError(res, error);
  }
}

async function completeStageCheckAndPropagate(req, res) {
  try {
    //? Check which stage it needs to to be shifted to and update tab automatically
    const otp = req.body.otp;
    const taskID = req.body.taskID;
    const stage = req.body.stage;

    result = await project.findOne(
      {
        "tasks.taskID": taskID,
      },
      {
        tasks: 1,
      }
    );
    if (!result) {
      return response.sendError(res, "Error occured while fetching task");
    }
    let obj;
    // console.log(result.tasks[0]);
    for (let index = 0; index < result.tasks.length; index++) {
      if (result.tasks[index].taskID == taskID) {
        obj = result.tasks[index];
      }
    }

    if (obj.token != otp) {
      return response.sendError(res, "OTP does not match");
    }
    if (obj.taskStage == stage) {
      return response.sendError(res, "Currently on the same stage");
    }
    if (obj.taskStage > stage) {
      return response.sendError(res, "Cannot go back to previous stage");
    }
    if (stage > 5) {
      return response.sendError(res, "Cannot cross stage limit");
    }

    //! Need for new token for next OTP
    token = rand("0", process.env.OTP_LENGTH);
    result = await project.updateOne(
      {
        "tasks.taskID": taskID,
      },
      {
        $set: {
          "tasks.$.taskStage": stage,
          "tasks.$.token": token,
        },
      }
    );
    if (!result) {
      return response.sendError(res, "Error occured updating task stage");
    }
    if(stage == 5){
      result = await project.updateOne(
        {
          "tasks.taskID": taskID,
        },
        {
          $set: {
            "projectStatus": "Closed"
          },
        }
      );
      if (!result) {
        return response.sendError(res, "Error occured updating task stage");
      }
    }
    return response.sendResponse(res, "Stage Completion Authenticated");
  } catch (error) {
    console.log(error);
    response.sendError(res, error);
  }
}
module.exports = {
  createTask,
  editTaskTitle,
  editTaskDescription,
  addAttachmentToTask,
  deleteAttachmentFromTask,
  completeStageInitiation,
  completeStageCheckAndPropagate,
};
