class Tasks {
  final String taskID;
  final int taskStage;
  final String taskTitle;
  final String description;
  final String date;
  // final List<> attachments;

  Tasks(
      {this.taskID,
      this.taskStage,
      this.taskTitle,
      this.description,
      this.date});

  factory Tasks.fromJson(Map<String, dynamic> json) {
    return Tasks(
      taskID: json['taskID'],
      taskStage: json['taskStage'],
      taskTitle: json['taskTitle'],
      date: json['date'],
      description: json['description'],
    );
  }
}
