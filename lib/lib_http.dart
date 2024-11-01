import 'package:dio/dio.dart';

import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:tp1/drawer.dart';
import 'package:tp1/transfer.dart';



class SingletonDio {
  static var cookiemanager = CookieManager(CookieJar());

  static Dio getDio() {
    Dio dio = Dio();
    dio.interceptors.add(cookiemanager);
    return dio;
  }

  static String server = "http://10.0.2.2:8080/";
}

Future<SigninResponse> signup(SignupRequest req) async {
  try {
    var response = await SingletonDio.getDio()
        .post(SingletonDio.server + 'api/id/signup', data: req.toJson());
    print(response);
    var signin = SigninResponse.fromJson(response.data);
    TNav.name = signin.username;
    return signin;
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future<SigninResponse> signin(SigninRequest req) async {
  try {
    var response = await SingletonDio.getDio()
        .post(SingletonDio.server + 'api/id/signin', data: req.toJson());
    print(response);
    var signin = SigninResponse.fromJson(response.data);
    TNav.name = signin.username;
    return signin;
  } catch (e) {
    print(e);
    rethrow;
  }
}

void signout() async {
  try {
    await SingletonDio.getDio()
        .post(SingletonDio.server + 'api/id/signout');
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future<List<HomeItemResponse>> getTasks() async {
  try {
    var response = await SingletonDio.getDio()
        .get(SingletonDio.server + 'api/home');
    print(response);
    var rawTasks = response.data as List;
    List<HomeItemResponse> tasks = [];
    tasks = rawTasks.map((task){
      return HomeItemResponse.fromJson(task);
    }).toList();
    print(tasks);
    return tasks;
  } catch (e) {
    print(e);
    rethrow;
  }
}

void addTask(AddTaskRequest req) async {
  try {
    await SingletonDio.getDio()
        .post(SingletonDio.server + 'api/add', data: req.toJson());
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future<TaskDetailResponse> taskDetails(int id) async {
  try {
    var response = await SingletonDio.getDio()
        .get(SingletonDio.server + 'api/detail/${id}');
    return TaskDetailResponse.fromJson(response.data);
  } catch (e) {
    print(e);
    rethrow;
  }
}

void changeProgress(int taskID, int value) async {
  try {
    await SingletonDio.getDio()
        .get(SingletonDio.server + 'api/progress/${taskID}/${value}');
  } catch (e) {
    print(e);
    rethrow;
  }
}