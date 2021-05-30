class ApiDataProvider {
  //* Get Routes

  static const String userProjects = "/getprojects";

  //* Post Routes

  static const String login = "/login";

  static const String register = "/register";

  static const String logout = "/logout";

  static const String createProject = "/createproject";

  static const String deleteProject = "/deleteproject";

  static const String changeDeadline = "/changedeadline";

  static const String changeTitle = "/changetitle";

  static const String addTask = "/addtask";

  static const String editTaskTitle = "/edittasktitle";

  static const String editTaskDescription = "/edittaskdescription";

  static const String initiateStageCompletion = "/initiatestagecompletion";

  static const String addAttachment = "/addattachment";

  static const String deleteAttachment = "/deleteattachment";

  static const String removeCollaborator = "/removecollaborator";

  static const String addCollaborator = "/addcollaborator";

  static const String init = "/init";

  static const String getCollaborators = "/getcollaborators";

  static const String getTasks = "/getTasks";

  static const String deleteTask = "/deletetask";

  static const String finishStageCompletion = '/finishstagecompletion';
}
