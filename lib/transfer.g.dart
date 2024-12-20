// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupRequest _$SignupRequestFromJson(Map<String, dynamic> json) =>
    SignupRequest()
      ..username = json['username'] as String
      ..password = json['password'] as String;

Map<String, dynamic> _$SignupRequestToJson(SignupRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

SigninRequest _$SigninRequestFromJson(Map<String, dynamic> json) =>
    SigninRequest()
      ..username = json['username'] as String
      ..password = json['password'] as String;

Map<String, dynamic> _$SigninRequestToJson(SigninRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

SigninResponse _$SigninResponseFromJson(Map<String, dynamic> json) =>
    SigninResponse()..username = json['username'] as String;

Map<String, dynamic> _$SigninResponseToJson(SigninResponse instance) =>
    <String, dynamic>{
      'username': instance.username,
    };

AddTaskRequest _$AddTaskRequestFromJson(Map<String, dynamic> json) =>
    AddTaskRequest()
      ..name = json['name'] as String
      ..deadline = DateTime.parse(json['deadline'] as String);

Map<String, dynamic> _$AddTaskRequestToJson(AddTaskRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'deadline': instance.deadline.toIso8601String(),
    };

HomeItemPhotoResponse _$HomeItemPhotoResponseFromJson(
        Map<String, dynamic> json) =>
    HomeItemPhotoResponse(
      nom: json['nom'] as String,
      pourcentage: (json['pourcentage'] as num).toInt(),
      deadline: DateTime.parse(json['deadline'] as String),
      creation_date: DateTime.parse(json['creation_date'] as String),
    )..photo = json['photo'] as String;

Map<String, dynamic> _$HomeItemPhotoResponseToJson(
        HomeItemPhotoResponse instance) =>
    <String, dynamic>{
      'nom': instance.nom,
      'pourcentage': instance.pourcentage,
      'deadline': instance.deadline.toIso8601String(),
      'creation_date': instance.creation_date.toIso8601String(),
      'photo': instance.photo,
    };

TaskDetailPhotoResponse _$TaskDetailPhotoResponseFromJson(
        Map<String, dynamic> json) =>
    TaskDetailPhotoResponse()
      ..id = (json['id'] as num).toInt()
      ..name = json['name'] as String
      ..percentageDone = (json['percentageDone'] as num).toInt()
      ..percentageTimeSpent = (json['percentageTimeSpent'] as num).toDouble()
      ..deadline = DateTime.parse(json['deadline'] as String)
      ..photoId = (json['photoId'] as num?)?.toInt();

Map<String, dynamic> _$TaskDetailPhotoResponseToJson(
        TaskDetailPhotoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'percentageDone': instance.percentageDone,
      'percentageTimeSpent': instance.percentageTimeSpent,
      'deadline': instance.deadline.toIso8601String(),
      'photoId': instance.photoId,
    };
