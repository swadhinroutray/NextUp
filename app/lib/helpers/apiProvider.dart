import 'package:dio/dio.dart';
import 'package:nextup/constants/apiPath.dart';
import 'package:nextup/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
  Dio _dio;
  String sessionCookie = '';

  final BaseOptions options = new BaseOptions(
    baseUrl: 'https://nextup-app-backend.herokuapp.com/api',
  );
  static final ApiProvider _instance = ApiProvider._internal();

  factory ApiProvider() => _instance;

  ApiProvider._internal() {
    _dio = Dio(options);
    _dio.interceptors.add(
        InterceptorsWrapper(onRequest: (RequestOptions options, handler) async {
      _dio.interceptors.requestLock.lock();
      options.headers["cookie"] = sessionCookie;
      _dio.interceptors.requestLock.unlock();
      handler.next(options); //continue
    }));
  }
  Future login(String email, String password) async {
    final request = {
      "email": email,
      "password": password,
    };

    final response = await _dio.post(ApiDataProvider.login, data: request);
    //get cooking from response
    // print(response.data['data']);
    if (response.data['data'] == 'An error Occured + Wrong Password' ||
        response.data['data'] == 'An error Occured + Invalid Credentials')
      return false;

    final cookies = response.headers['set-cookie'];
    if (cookies.isNotEmpty) {
      //saving this to global variable to refresh current api calls to add cookie.
      sessionCookie = cookies[0];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('cookie', sessionCookie);
    }

    // print(response.data);

    if (response.data['success'] == true) {
      //initialize user data
      User.fromJson(response.data['data']);
      return true;
    }

    return false;
  }

  Future<int> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cookie');
    var response = await _dio.post(ApiDataProvider.logout);
    return (response.statusCode);
  }

  Future register(
      String name, String email, String password, String contact) async {
    final request = {
      "email": email.trim(),
      "password": password.trim(),
      "name": name.trim(),
      "contact": contact.trim()
    };
    final response = await _dio.post(ApiDataProvider.register, data: request);
    if (!response.data['data'].containsKey('error')) {
      return response.data['success'];
    } else {
      return null;
    }
  }

  Future initSession() async {
    final prefs = await SharedPreferences.getInstance();
    sessionCookie = prefs.getString('cookie');
    if (sessionCookie != null) {
      final response = await _dio.get(ApiDataProvider.init);

      //initialize user data
      User.fromJson(response.data['data']['user']);

      return (response.data);
    } else
      return null;
  }

  Future<List<dynamic>> getUserProjects() async {
    var response = await _dio.get(ApiDataProvider.userProjects);
    List<dynamic> projects = [];
    for (var data in response.data['data']) {
      projects.add(data);
    }
    if (projects.length == 0)
      return null;
    else
      return projects;
  }

  Future createProject(String title, String deadline) async {
    final request = {"title": title.trim(), "date": deadline.trim()};
    final response =
        await _dio.post(ApiDataProvider.createProject, data: request);
    if (response.data['success'] == true) {
      //initialize user data
      return true;
    }

    return false;
  }

  Future createTask(String projectID, String title, String description) async {
    final request = {
      "projectID": projectID,
      "title": title.trim(),
      "description": description.trim()
    };
    final response = await _dio.post(ApiDataProvider.addTask, data: request);
    if (response.data['success'] == true) {
      //initialize user data
      return true;
    }

    return false;
  }

  Future<List<dynamic>> getCollaborators(String projectID) async {
    final request = {"projectID": projectID};

    final response =
        await _dio.post(ApiDataProvider.getCollaborators, data: request);
    List<dynamic> collaborators = [];
    if (response.data['success'] == true) {
      //initialize user data
      for (var data in response.data['data']['collaborators']) {
        collaborators.add(data);
      }
    }
    if (collaborators.length == 0)
      return null;
    else
      return collaborators;
  }

  Future addCollaborator(String projectID, String email) async {
    final request = {
      "projectID": projectID,
      "email": email.trim(),
    };
    final response =
        await _dio.post(ApiDataProvider.addCollaborator, data: request);
    if (response.data['success'] == true) {
      //initialize user data
      return true;
    }

    return false;
  }

  Future removeCollaborator(String projectID, String userID) async {
    final request = {
      "userID": userID.trim(),
      "projectID": projectID.trim(),
    };
    final response =
        await _dio.post(ApiDataProvider.removeCollaborator, data: request);
    if (response.data['success'] == true) {
      //initialize user data
      return true;
    }

    return false;
  }

  Future<List<dynamic>> getTasks(String projectID, int stage) async {
    final request = {"projectID": projectID.trim(), "stage": stage};
    final response = await _dio.post(ApiDataProvider.getTasks, data: request);
    if (response.data['success'] == true) {
      //initialize user data
      return response.data['data'];
    }

    return null;
  }

  Future removeTask(String projectID, String taskID) async {
    final request = {"projectID": projectID.trim(), "taskID": taskID};
    final response = await _dio.post(ApiDataProvider.deleteTask, data: request);
    if (response.data['success'] == true) {
      //initialize user data
      return true;
    }

    return null;
  }

  Future initiateStagePropagation(String taskID) async {
    final request = {"taskID": taskID};
    final response =
        await _dio.post(ApiDataProvider.initiateStageCompletion, data: request);
    if (response.data['success'] == true) {
      //initialize user data
      return true;
    }

    return null;
  }

  Future completeStagePropagation(String taskID, String otp, int stage) async {
    int newStage = stage + 1;
    print(newStage);
    final request = {"taskID": taskID, "otp": otp, "stage": newStage};
    final response =
        await _dio.post(ApiDataProvider.finishStageCompletion, data: request);

    if (response.data['data'] == 'An error Occured + OTP does not match') {
      //initialize user data
      return false;
    }

    if (response.data['success'] == true) {
      //initialize user data
      return true;
    }

    return false;
  }
}
