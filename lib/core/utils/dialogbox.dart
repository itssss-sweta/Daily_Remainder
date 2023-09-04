import 'dart:developer';

import 'package:daily_remainder/core/colors.dart';
import 'package:daily_remainder/core/textstyle.dart';
import 'package:daily_remainder/features/button.dart';
import 'package:daily_remainder/features/inputbox.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final _task = TextEditingController();
final _date = TextEditingController();

final _time = TextEditingController();

Future showMyDialog(BuildContext context) {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  return showDialog(
      context: context,
      barrierDismissible: false,
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
          content: Column(
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
                controller: _task,
                inputType: TextInputType.text,
                hintText: 'Enter task',
                obscureText: false,
                isSmall: false,
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
                          controller: _date,
                          inputType: TextInputType.datetime,
                          hintText: 'YYYY-MM-DD',
                          obscureText: false,
                          isSmall: false,
                          readOnly: true,
                          onTap: () async {
                            final datePick = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2030),
                            );

                            // String formattedDate = format;

                            if (datePick != null && datePick != selectedDate) {
                              // log(datePick.toString());s
                              selectedDate = datePick;
                              _date.text =
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
                          controller: _time,
                          inputType: TextInputType.datetime,
                          hintText: '12:00',
                          obscureText: false,
                          isSmall: false,
                          readOnly: true,
                          onTap: () async {
                            final timePicked = await showTimePicker(
                              context: context,
                              initialTime: selectedTime,
                            );

                            if (timePicked != null &&
                                timePicked != selectedTime) {
                              // log(timePicked
                              //     .toString()
                              //     .split('(')
                              //     .elementAt(1));
                              selectedTime = timePicked;
                              _time.text =
                                  '${selectedTime.hour.toString().padLeft(2, '0')}: ${selectedTime.minute.toString().padLeft(2, '0')}';
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
          actions: [
            ButtonTap(
              text: 'Add',
              onTap: () {
                log(selectedDate.toString());

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
