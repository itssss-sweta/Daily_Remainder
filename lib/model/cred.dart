import 'dart:convert';

import 'package:daily_remainder/model/task.dart';

CredentialsUser credentialsUserFromJson(String str) =>
    CredentialsUser.fromJson(json.decode(str));

String credentialsUserToJson(CredentialsUser data) =>
    json.encode(data.toJson());

class CredentialsUser {
  String? email;
  String? password;
  List<Tasks>? task;

  CredentialsUser({
    this.email,
    this.password,
    this.task,
  });
  CredentialsUser.fromJson(Map<String, dynamic> json) {
    email = json['email']?.toString();
    password = json['password']?.toString();
    // task = json['task']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    // data['task'] = task;
    return data;
  }
}
