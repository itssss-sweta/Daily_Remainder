import 'dart:developer';
import 'package:daily_remainder/config/routes/routes.dart';
import 'package:daily_remainder/core/colors.dart';
import 'package:daily_remainder/core/constant.dart';
import 'package:daily_remainder/core/utils/provider.dart';
import 'package:daily_remainder/model/cred.dart';
import 'package:daily_remainder/model/task.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

//Login and Register

Map<String, String>? credentials = {};

List<String> keys = credentials?.keys.toList() ?? [];
List<String> values = credentials?.values.toList() ?? [];

initializeCredentials() {
  final storage = GetStorage();
  final storedData = storage.read(registerKey);
  if (storedData != null) {
    credentials = Map<String, String>.from(storedData);
  }
}

// void storeData(Map data) {
//   final storage = GetStorage();
//   storage.write(loginKey, credentials);
// }

void storeRegData() {
  final storage = GetStorage();
  storage.write(registerKey, credentials);
}

void addRegisterData(String email, String password) {
  credentials?.addAll({email: password});
  storeRegData();

  log(credentials.toString());
}

String? retrieveData() {
  final storage = GetStorage();
  final data = storage.read(loginKey);
  return data;
}

void authenticate(BuildContext context, String email, String password) {
  List<String> keys = credentials?.keys.toList() ?? [];
  // log(keys.toString());
  List<String> values = credentials?.values.toList() ?? [];

  if (keys.contains(email) == true) {
    var indexofEmail = keys.indexOf(email);
    var storedPassword = values[indexofEmail];

    if (storedPassword == password) {
      final checkUser = currentUser?.taskData?.map((e) => e.email).toList();
      if (checkUser != null && checkUser.contains(email)) {
        initializeTask(email).whenComplete(() {
          var filteredTask = currentUser?.taskData
              ?.where((value) => value.email == email)
              .toList();

          final filter = Provider.of<TaskProvider>(context, listen: false);
          // taskData = filteredTask;
          filter.updateTasks(filteredTask ?? []);
          filter.setEmail(email);
        });
      }

      Navigator.pushNamed(context, Routes.home);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Login Successful',
            style: TextStyle(color: buttonColor),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.grey.shade100.withOpacity(.8),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      wrongCred(context);
    }
  } else {
    wrongCred(context);
  }
}

void wrongCred(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text(
        'Please check your credentials and try again',
        style: TextStyle(color: Colors.red),
      ),
      backgroundColor: Colors.grey.shade300,
      duration: const Duration(seconds: 2),
    ),
  );
}

void deleteData() {
  final storage = GetStorage();
  storage.remove(loginKey);
}

final userStorage = GetStorage(keys.toString());

//store task in list

// List<Tasks>? taskData = [];
CredentialsUser? currentUser = CredentialsUser(taskData: []);

Future<List<Tasks>> initializeUserOldTasks() async {
  final storage = GetStorage();
  final oldTasks = storage.read(taskKey);
  // final tasks = oldTasks
  if (oldTasks != null) {
    final tasks = (oldTasks as List).map((e) => tasksFromJson(e)).toList();
    return tasks;
  }
  return [];
}

Future<List<Tasks>> initializeTask(String email) async {
  final oldTasks = await initializeUserOldTasks();
  final availableStringTask = retrieveTask(email);
  currentUser?.email = email;
  if (availableStringTask != null) {
    final List<Tasks> filteredTasks =
        availableStringTask.map((e) => tasksFromJson(e)).toList();
    // return [...oldTasks, ...filteredTasks];
    oldTasks.addAll(filteredTasks);
    currentUser?.taskData = filteredTasks;
    return filteredTasks;
  }
  return [];
}

void storeTask(List<Tasks> tasks, String email) {
  final storage = GetStorage();
  final convertedListString = tasks.map((e) => tasksToJson(e)).toList();
  storage.write('$taskKey$email', convertedListString);
}

void addTask(Tasks tasks, String email) {
  currentUser?.email = email;
  currentUser?.taskData?.add(tasks);
  storeTask(currentUser?.taskData ?? [], email);
}

void replaceeditedTask(Tasks tasks, String email) {
  int id = tasks.id ?? 0;
  int? index = currentUser?.taskData?.indexWhere((element) => id == element.id);
  currentUser?.taskData?[index!] = tasks;
  storeTask(currentUser?.taskData ?? [], email);
}

List<String>? retrieveTask(String email) {
  final storage = GetStorage();
  final data = storage.read('$taskKey$email');
  if (data != null) {
    final listTask = (data as List).map((e) => e.toString()).toList();
    final filteredTask =
        listTask.where((element) => element.contains(email)).toList();
    return filteredTask;
  }
  return [];
}
