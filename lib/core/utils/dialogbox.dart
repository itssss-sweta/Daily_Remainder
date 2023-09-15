import 'dart:developer';
import 'package:daily_remainder/core/colors.dart';
import 'package:daily_remainder/core/textstyle.dart';
import 'package:daily_remainder/core/utils/provider.dart';
import 'package:daily_remainder/features/button.dart';
import 'package:daily_remainder/features/inputbox.dart';
import 'package:daily_remainder/model/task.dart';
import 'package:daily_remainder/screen3/login.dart';
import 'package:daily_remainder/storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DialogUtils {
  LoginPage emailLogin = const LoginPage();
  // final notifiationsService = NotificationsService();
  Future showMyDialog(BuildContext context, {Tasks? savedtask}) {
    final emailUser = Provider.of<TaskProvider>(context, listen: false);
    final useEmail = emailUser.getemail;
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();
    final task = TextEditingController();
    final date = TextEditingController();

    final time = TextEditingController();
    final key = GlobalKey<FormState>();

    if (savedtask != null) {
      task.text = savedtask.task ?? '';
      date.text = savedtask.date ?? '';
      time.text = savedtask.time ?? '';
    }
    return showDialog(
        context: context,
        // barrierDismissible: false,

        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 1,
            backgroundColor: alertBoxColor,
            title: Align(
              child: Text(
                'Add Task:',
                style: headStyle,
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            content: Form(
              key: key,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // InkWell(
                  //   onTap: () {
                  //     Navigator.of(context).pop();
                  //   },
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       color: backgroundColor.withOpacity(1),
                  //     ),
                  //     child: const Icon(
                  //       Icons.close,
                  //       color: Colors.white,
                  //       size: 15,
                  //     ),
                  //   ),
                  // ),
                  InputTextBox(
                    controller: task,
                    inputType: TextInputType.text,
                    hintText: 'Enter task',
                    obscureText: false,
                    isSmall: false,
                    onTap: () {},
                    error: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'enter task';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Text(
                              'Date:',
                              style: headStyle,
                              textAlign: TextAlign.start,
                            ),
                            InputTextBox(
                              controller: date,
                              inputType: TextInputType.datetime,
                              hintText: 'YYYY-MM-DD',
                              obscureText: false,
                              isSmall: false,
                              readOnly: true,
                              error: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'enter task';
                                }
                                return null;
                              },
                              onTap: () async {
                                final datePick = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2030),
                                  builder: (context, child) {
                                    return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: const ColorScheme.light(
                                            primary: buttonColor,
                                          ),
                                        ),
                                        child: child!);
                                  },
                                );

                                if (datePick != null &&
                                    datePick != selectedDate) {
                                  selectedDate = datePick;
                                  date.text =
                                      DateFormat.yMd().format(selectedDate);
                                  log(DateFormat.yMd()
                                      .format(selectedDate)
                                      .toString());
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Text(
                              'Time:',
                              style: headStyle,
                              textAlign: TextAlign.start,
                            ),
                            InputTextBox(
                              controller: time,
                              inputType: TextInputType.datetime,
                              hintText: '12:00',
                              obscureText: false,
                              isSmall: false,
                              readOnly: true,
                              error: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'enter task';
                                }
                                return null;
                              },
                              onTap: () async {
                                final timePicked = await showTimePicker(
                                  context: context,
                                  initialTime: selectedTime,
                                  builder: (context, child) {
                                    return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: const ColorScheme.light(
                                            primary: buttonColor,
                                          ),
                                        ),
                                        child: child!);
                                  },
                                );

                                if (timePicked != null &&
                                    timePicked != selectedTime) {
                                  // log(timePicked
                                  //     .toString()
                                  //     .split('(')
                                  //     .elementAt(1));
                                  selectedTime = timePicked;
                                  time.text =
                                      '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}';
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              ButtonTap(
                text: 'Add',
                onTap: () {
                  // log(selectedDate.toString());
                  // if(task)
                  if (key.currentState?.validate() ?? false) {
                    final taskDone = Tasks(
                      // checkbox: false,
                      task: task.text,
                      date: date.text,
                      time: time.text,
                      id: DateTime.now().millisecondsSinceEpoch,
                      completed: false,
                      email: useEmail,
                    );
                    // log(taskDone);

                    if (savedtask != null) {
                      final taskEditingDone = Tasks(
                        checkbox: savedtask.checkbox,
                        id: savedtask.id,
                        task: task.text,
                        date: date.text,
                        time: time.text,
                        completed: savedtask.completed,
                        email: useEmail,
                      );
                      // notificationsService.scheduleNotification(
                      //     taskEditingDone.id ?? 0, 'Notification', task.text);
                      replaceeditedTask(taskEditingDone, useEmail);
                      // notificationsService.customizeNotification(
                      //             id: Tasks().id,

                      //             body: Tasks().task,
                      //             scheduledDate: Tasks().date,

                      //           ),
                      // notificationsService.customizeNotification(
                      //   id: DateTime.now().millisecondsSinceEpoch,
                      //   body: task.text,
                      //   // scheduledDate: TZDateTime.from(
                      //   //   DateTime.parse(date.text),
                      //   //   Location('', [0], [0], [TimeZone.UTC]),
                      //   // ),
                      //   scheduledDate: tz.TZDateTime(
                      //       tz.getLocation('Nepal/Kathmandu'),
                      //       int.tryParse(date.text.split('-').first) ?? 0),
                      // );
                      Navigator.of(context).pop(taskEditingDone);
                    } else {
                      addTask(taskDone, useEmail);

                      // notificationsService.scheduleNotification(
                      //     taskDone.id ?? 0, 'Notification', task.text);
                      Navigator.of(context).pop(taskDone);
                    }
                  }
                },
              ),
            ],
          );
        });
  }
}
