const { project } = require("../models/projectSchema");
const { user } = require("../models/userSchema");
const response = require("../utils/responseHandler");
const { uuid } = require("uuidv4");

async function addCollaboratorToProject(req, res) {
  try {
  } catch (error) {
    console.log(error);
    response.sendError(res, error);
  }
}

module.exports = {};
