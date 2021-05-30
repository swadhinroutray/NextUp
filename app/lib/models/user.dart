class User {
  String userID;
  String name;
  String email;
  String contact;
  List<String> projects = [];

  // static String sid; //remove after debugging. move to secure storage
  User({this.userID, this.name, this.email, this.contact, this.projects});

  User.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    name = json['name'];
    email = json['email'];
    contact = json['contact'];
    projects = json['projects'].cast<String>();
  }
}
