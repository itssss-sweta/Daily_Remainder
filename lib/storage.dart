import 'dart:developer';
import 'package:daily_remainder/config/routes/routes.dart';
import 'package:daily_remainder/core/colors.dart';
import 'package:daily_remainder/core/constant.dart';
import 'package:daily_remainder/model/task.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

//Login and Register

// Map<String, String> credentials = {
//   'sweta@sweta.com': '12345678910',
//   'abc@abc.com': '12345678910abc',
//   'diff@diff.com': 'abcdefghijk',
// };
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

void storeData(Map data) {
  final storage = GetStorage();
  storage.write(loginKey, credentials);
}

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
  if (keys.contains(email)) {
    var indexofEmail = keys.indexOf(email);
    var storedPassword = values[indexofEmail];

    if (storedPassword == password) {
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
    }
  } else {
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
}

void deleteData() {
  final storage = GetStorage();
  storage.remove(loginKey);
}

final userStorage = GetStorage(keys.toString());

//store task in list

List<Tasks>? taskData = [];

Future initializeTask() async {
  final availableStringTask = retrieveTask();

  if (availableStringTask != null) {
    taskData = availableStringTask.map((e) => tasksFromJson(e)).toList();
  }
}

void storeTask(List<Tasks> tasks) {
  final storage = GetStorage();
  final convertedListString = tasks.map((e) => tasksToJson(e)).toList();
  storage.write(taskKey, convertedListString);
}

void addTask(Tasks tasks) {
  taskData?.add(tasks);
  storeTask(taskData!);
}

void replaceeditedTask(Tasks tasks) {
  int id = tasks.id ?? 0;
  int? index = taskData?.indexWhere((element) => id == element.id);
  taskData?[index!] = tasks;
  storeTask(taskData!);
}

List<String>? retrieveTask() {
  final storage = GetStorage();
  final data = storage.read(taskKey);
  final listTask = (data as List).map((e) => e.toString()).toList();
  return listTask;
}
