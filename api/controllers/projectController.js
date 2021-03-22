const project = require("../models/projectSchema");
const response = require("../utils/responseHandler");
async function createProject(req, res) {
  try {
    // // TODO: Need to establish a session to  get the name of creator and his object
  } catch (error) {
    console.log(error);
    response.sendError(res, error);
  }
}

module.exports = {};
