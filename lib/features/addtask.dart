import 'package:daily_remainder/core/utils/dialogbox.dart';
import 'package:daily_remainder/model/task.dart';
import 'package:flutter/material.dart';
// import '../core/utils/dialogbox.dart';

class TaskData extends StatefulWidget {
  const TaskData({super.key});

  @override
  State<TaskData> createState() => _TaskDataState();
}

class _TaskDataState extends State<TaskData> {
  final List<Tasks> _allTasks = <Tasks>[];
  // final _task = TextEditingController();
  DialogUtils dialogUtils = DialogUtils();

  void addTask(String task) {
    setState(() {
      _allTasks.add(Tasks(
        task: task,
      ));
    });
  }

  // static List<Tasks> getAllTasks() {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
