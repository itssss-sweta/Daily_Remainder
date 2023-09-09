import 'dart:convert';

Tasks tasksFromJson(String str) => Tasks.fromJson(json.decode(str));

String tasksToJson(Tasks data) => json.encode(data.toJson());

class Tasks {
  String? task;
  String? date;
  String? time;
  bool? completed;
  int? id;

  Tasks({
    this.task,
    this.date,
    this.time,
    this.completed,
    this.id,
  });
  Tasks.fromJson(Map<String, dynamic> json) {
    task = json['task']?.toString();
    date = json['date']?.toString();
    time = json['time']?.toString();
    completed = json['completed'];
    id = json['id']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['task'] = task;
    data['date'] = date;
    data['time'] = time;
    data['completed'] = completed;
    data['id'] = id;

    return data;
  }
}
