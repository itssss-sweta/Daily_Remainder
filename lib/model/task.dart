import 'dart:convert';

Tasks tasksFromJson(String str) => Tasks.fromJson(json.decode(str));

String tasksToJson(Tasks data) => json.encode(data.toJson());

class Tasks {
  bool? checkbox;
  String? task;
  String? date;
  String? time;
  bool? completed;
  int? id;
  String? email;

  Tasks({
    this.checkbox,
    this.task,
    this.date,
    this.time,
    this.completed,
    this.id,
    this.email,
  });
  Tasks.fromJson(Map<String, dynamic> json) {
    checkbox = json['checkbox'];
    task = json['task']?.toString();
    date = json['date']?.toString();
    time = json['time']?.toString();
    completed = json['completed'];
    id = json['id']?.toInt();
    email = json['email']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['checkbox'] = checkbox;
    data['task'] = task;
    data['date'] = date;
    data['time'] = time;
    data['completed'] = completed;
    data['id'] = id;
    data['email'] = email;

    return data;
  }
}
