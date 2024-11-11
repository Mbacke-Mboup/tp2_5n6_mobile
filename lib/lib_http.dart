import 'dart:ffi';

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
  static String image = "http://10.0.2.2:8080/file/";
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

Future<List<HomeItemPhotoResponse>> getTasks() async {
  try {
    var response = await SingletonDio.getDio()
        .get(SingletonDio.server + 'api/home/photo');
    print(response);
    var rawTasks = response.data as List;
    List<HomeItemPhotoResponse> tasks = [];
    tasks = rawTasks.map((task){
      return HomeItemPhotoResponse.fromJson(task);
    }).toList();
    print(tasks);
    return tasks;
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future<String> sendImage(String filePath, String fileName, int taskId) async{
  try{

    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath,filename:  fileName),
      'taskID' : taskId
    });
 var response = await SingletonDio.getDio().post(SingletonDio.server +'file', data: formData);
 String idImage = response.toString();
 var result = SingletonDio.image+idImage;
  return result;
  }catch(e) {
    print(e);
    rethrow;
  }
}

Future<void> addTask(AddTaskRequest req) async {
  try {
    await SingletonDio.getDio()
        .post(SingletonDio.server + 'api/add', data: req.toJson());
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future<void> removeTask(int taskId) async {
  try{
    await SingletonDio.getDio().delete(SingletonDio.server+"api/delete/${taskId}");
  }catch(e){
    rethrow;
  }
}

Future<TaskDetailPhotoResponse> taskDetails(int id) async {
  try {
    var response = await SingletonDio.getDio()
        .get(SingletonDio.server + 'api/detail/photo/${id}');
    return TaskDetailPhotoResponse.fromJson(response.data);
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