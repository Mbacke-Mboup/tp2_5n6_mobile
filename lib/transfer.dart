import 'package:json_annotation/json_annotation.dart';
part 'transfer.g.dart';

@JsonSerializable()
class SignupRequest {
  SignupRequest();

  String username = '';
  String password = '';

  factory SignupRequest.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignupRequestToJson(this);
}

@JsonSerializable()
class SigninRequest {
  SigninRequest();

  String username = '';
  String password = '';

  factory SigninRequest.fromJson(Map<String, dynamic> json) =>
      _$SigninRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SigninRequestToJson(this);
}

@JsonSerializable()
class SigninResponse {
  SigninResponse();

  String username = '';

  factory SigninResponse.fromJson(Map<String, dynamic> json) =>
      _$SigninResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SigninResponseToJson(this);
}

@JsonSerializable()
class AddTaskRequest {
  AddTaskRequest();

  String name = '';
  DateTime deadline = DateTime.now();

  factory AddTaskRequest.fromJson(Map<String, dynamic> json) =>
      _$AddTaskRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddTaskRequestToJson(this);
}

@JsonSerializable()
class HomeItemPhotoResponse {
  HomeItemPhotoResponse();
  int id = 0;
  String name = "";
  int percentageDone = 0;
  double percentageTimeSpent = 0;
  DateTime deadline = DateTime.now();
  int? photoId = 0;
  factory HomeItemPhotoResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeItemPhotoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeItemPhotoResponseToJson(this);
}

@JsonSerializable()
class TaskDetailPhotoResponse {
  TaskDetailPhotoResponse();

  int id = 0;
  String name = "";
  int percentageDone = 0;
  double percentageTimeSpent = 0;
  DateTime deadline = DateTime.now();
  int? photoId = 0;

  factory TaskDetailPhotoResponse.fromJson(Map<String, dynamic> json) =>
      _$TaskDetailPhotoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TaskDetailPhotoResponseToJson(this);
}