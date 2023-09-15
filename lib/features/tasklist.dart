import 'dart:developer';
import 'package:daily_remainder/core/colors.dart';
import 'package:daily_remainder/core/constant.dart';
import 'package:daily_remainder/core/textstyle.dart';
import 'package:daily_remainder/core/utils/dialogbox.dart';

import 'package:daily_remainder/model/task.dart';
import 'package:flutter/material.dart';

class TaskList extends StatefulWidget {
  final List<Tasks>? allTasks;
  // final List<CredentialsUser>? credentials;

  const TaskList({
    super.key,
    this.allTasks,
    // this.credentials,
  });

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  // bool completed = false;
  DialogUtils dialogUtils = DialogUtils();
  int? deleteIndex;
  Tasks? deleteTasks;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          // shrinkWrap: true,
          itemCount: widget.allTasks?.length,
          itemBuilder: (context, index) {
            final tasks = widget.allTasks?[index];
            return Padding(
              padding: colpadding,
              child: Container(
                padding: contentPadding,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: backgroundColor.withOpacity(.2),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        var editedTask = await dialogUtils.showMyDialog(context,
                            savedtask: tasks);

                        setState(() {
                          if (editedTask != null) {
                            // setState(() {});
                            // var a = widget.allTasks
                            //     ?.where((element) => element.id == editedTask.id);
                            var b = widget.allTasks?.indexWhere(
                                (element) => element.id == editedTask.id);
                            if (b != null) {
                              // widget.allTasks?.insert(b, editedTask); //inserts an element before the given index
                              widget.allTasks?[b] =
                                  editedTask; //replaces the element
                            }
                          }
                        });
                      },
                      child: Row(
                        children: [
                          Checkbox(
                            activeColor: buttonColor,
                            value: tasks?.completed ?? false,
                            checkColor: listContainerColor,
                            onChanged: (value) {
                              setState(() {
                                tasks?.completed = value;
                                tasks?.checkbox = value;
                              });
                            },
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: tasks?.completed ?? false
                                      ? Text(
                                          tasks?.task ?? '',
                                          style: completedTextStyle,
                                        )
                                      : Text(
                                          tasks?.task ?? '',
                                          style: taskTextStyle,
                                        ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      tasks?.date ?? '',
                                      style: dateTextStyle,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      tasks?.time ?? '',
                                      style: dateTextStyle,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              log(tasks!.id.toString());
                              deleteIndex = index;
                              deleteTasks = tasks;
                              setState(() {
                                widget.allTasks?.removeAt(index);
                              });

                              // final deletedTask = widget.allTasks!.removeWhere(
                              //     (element) => element.id == deleteId);
                              // final deletedId = widget.allTasks!.indexWhere(
                              //     (element) => element.id == deleteId);
                              // log(deletedItem.toString());

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      const Text('Your task has been deleted'),
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () {
                                      if (deleteIndex != null &&
                                          deleteTasks != null) {
                                        setState(() {
                                          widget.allTasks?.insert(
                                              deleteIndex!, deleteTasks!);
                                          deleteIndex = 0;
                                          deleteTasks = Tasks();
                                        });
                                      }
                                    },
                                  ),
                                  duration: const Duration(seconds: 2),
                                  backgroundColor:
                                      backgroundColor.withOpacity(.8),
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.delete,
                              color: buttonColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
