import 'package:daily_remainder/model/task.dart';

class CredentialsUser {
  // Map<String, String>? credentials;
  String? email;
  List<Tasks>? taskData;

  CredentialsUser({
    this.email,
    // this.password,
    this.taskData = const [],
  });
}
