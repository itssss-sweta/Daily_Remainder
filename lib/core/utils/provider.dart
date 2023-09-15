import 'package:daily_remainder/model/task.dart';
import 'package:flutter/foundation.dart';

class TaskProvider extends ChangeNotifier {
  List<Tasks> _allTasks = [];

  List<Tasks> get allTasks => _allTasks;

  updateTasks(List<Tasks> newTasks) {
    _allTasks = newTasks;
    notifyListeners();
  }

  String _email = '';

  String get getemail => _email;

  setEmail(String newEmail) {
    _email = newEmail;
    notifyListeners();
  }
}
