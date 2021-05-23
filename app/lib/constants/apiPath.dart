class ApiDataProvider {
  static const String prefix = "http://localhost:1337/api/";

  //* Get Routes

  static const String userProjects = prefix + "getprojects";

  //* Post Routes

  static const String login = prefix + "login";

  static const String register = prefix + "register";

  static const String logout = prefix + "logout";

  static const String createProject = prefix + "createproject";

  static const String deleteProject = prefix + "deleteproject";

  static const String changeDeadline = prefix + "changedeadline";

  static const String changeTitle = prefix + "changetitle";

  static const String addTask = prefix + "addtask";

  static const String editTaskTitle = prefix + "edittasktitle";

  static const String editTaskDescription = prefix + "edittaskdescription";

  static const String initiateStageCompletion =
      prefix + "initiatestagecompletion";

  static const String addAttachment = prefix + "addattachment";

  static const String deleteAttachment = prefix + "deleteattachment";

  static const String finishStageCompletion = prefix + "finishstagecompletion";
}
