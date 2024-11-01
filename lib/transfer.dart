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
class HomeItemResponse {
  HomeItemResponse();
  int id = 0;
  String name = "";
  int percentageDone = 0;
  double percentageTimeSpent = 0;
  DateTime deadline = DateTime.now();

  factory HomeItemResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeItemResponseToJson(this);
}

@JsonSerializable()
class TaskDetailResponse {
  TaskDetailResponse();

  int id = 0;
  String name = "";
  int percentageDone = 0;
  double percentageTimeSpent = 0;
  DateTime deadline = DateTime.now();

  factory TaskDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$TaskDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TaskDetailResponseToJson(this);
}