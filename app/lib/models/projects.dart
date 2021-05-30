import 'package:nextup/models/tasks.dart';

class Project {
  String projectID;
  String deadline;
  String title;
  String projectStatus;
  List<Tasks> tasks = [];

  Project(
      {this.projectID,
      this.deadline,
      this.title,
      this.projectStatus,
      this.tasks});

  factory Project.fromJson(Map<String, dynamic> json, List<dynamic> itemJson) {
    return Project(
      projectID: json['projectID'],
      deadline: json['deadline'],
      title: json['title'],
      projectStatus: json['projectStatus'],
      tasks: itemJson
          .map((i) {
            return Tasks.fromJson(i);
          })
          .toList()
          .cast<Tasks>(),
    );
  }
}
