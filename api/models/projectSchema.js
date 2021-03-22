const mongoose = require("mongoose");

const taskSchema = new mongoose.Schema({
  taskID: {
    type: String,
  },
  taskTitle: {
    type: String,
  },
  taskStage: {
    //! Stages defined by number, Check README for the same.
    type: Number,
  },
  attachments: {
    //! To attach a picture to the particular task
    type: Array,
  },
  token: {
    type: String, //* To Allow 2FA on moving stages.
  },
  description:{
    type:String
  },
  createdAt:{
    type: Date
  }
});

const projectSchema = new mongoose.Schema({
  projectID: {
    type: String,
  },
  createdBy: {
    type: Object,
  },
  deadline: {
    type: Date,
  },
  title: {
    type: String,
  },
  tasks: {
    type: [taskSchema],
  },
  projectStatus: {
    //? Active for first four tabs and completed when we move to the completed tab,i.e., after the fourth stage
    type: String,
  },
  collaborators: {
    type: Array,
  },
});

const project = mongoose.model("projects", projectSchema);
const task = mongoose.model("tasks", taskSchema);
module.exports = {
  project,
  task,
};
