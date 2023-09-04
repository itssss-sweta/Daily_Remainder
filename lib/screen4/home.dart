import 'package:daily_remainder/core/colors.dart';
import 'package:daily_remainder/core/constant.dart';
import 'package:daily_remainder/core/textstyle.dart';
import 'package:daily_remainder/core/utils/dialogbox.dart';
import 'package:daily_remainder/features/ellipse.dart';
import 'package:daily_remainder/features/switch.dart';
import 'package:daily_remainder/model/task.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<Tasks> allTasks = [
  //   Tasks('Do chores'),
  // ];

  // void createTask({
  //   String? task,
  //   // String? date,
  //   // String? time,
  // }) {
  //   Tasks newTask = Tasks(
  //     task: task,
  //     // date: date,
  //     // time: time,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: 251,
                color: containerColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      'images/user.png',
                      height: 100,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Sweta Maharjan',
                      style: buttonTextStyle,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: colpadding,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'Good Afternoon',
                            style: bodyTextStyle,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Tasks List',
                            style: bodyTextStyle,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: listContainerColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: colpadding,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Daily Tasks',
                                        style: listTextStyle,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showMyDialog(context);
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: backgroundColor,
                                          ),
                                          child: const Icon(Icons.add),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: Icon(
                                            Icons.circle,
                                            opticalSize: 10,
                                          ),
                                          title: Text('Do chores'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Additional features',
                            style: bodyTextStyle,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          //height: 175,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: listContainerColor,
                          ),
                          child: Padding(
                            padding: textPadding,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ListTile(
                                  title: Text(
                                    'Water Reminder',
                                    style: headStyle,
                                  ),
                                  trailing: const SwitchButton(),
                                ),
                                ListTile(
                                  title: Text(
                                    'Screen Break',
                                    style: headStyle,
                                  ),
                                  trailing: const SwitchButton(),
                                ),
                                ListTile(
                                  title: Text(
                                    'Motivational Quotes',
                                    style: headStyle,
                                  ),
                                  trailing: const SwitchButton(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Ellipse(
            color: ellipselightColor,
          ),
        ],
      ),
    );
  }
}
