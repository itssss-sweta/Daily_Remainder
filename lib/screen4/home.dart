import 'package:daily_remainder/config/routes/routes.dart';
import 'package:daily_remainder/core/colors.dart';
import 'package:daily_remainder/core/constant.dart';
import 'package:daily_remainder/core/textstyle.dart';
import 'package:daily_remainder/core/utils/dialogbox.dart';
import 'package:daily_remainder/core/utils/provider.dart';
import 'package:daily_remainder/features/tasklist.dart';
import 'package:daily_remainder/features/ellipse.dart';
import 'package:daily_remainder/features/switch.dart';
import 'package:daily_remainder/screen3/login.dart';
import 'package:daily_remainder/storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LoginPage login = const LoginPage();
  // List<Tasks> allTasks = [];
  DialogUtils dialogUtils = DialogUtils();

  @override
  void initState() {
    super.initState();
    final taskProvider = context.read<TaskProvider>();

    final email = taskProvider.getemail;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // initializeTask(email).whenComplete(() {
      //   // setState(() {
      //   //   allTasks = taskData ?? [];
      //   // });
      //   final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      //   taskProvider.updateTasks(currentUser?.taskData ?? []);
      // });
      initializeTask(email).then((tasks) => taskProvider.updateTasks(tasks));

      // initializeUserOldTasks();
      //   //can use context.read/context.watch instead because stateless
      //   // final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      //   final taskProvider = context.read<TaskProvider>();
      //   taskProvider.updateTasks(taskData ?? []);
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final useEmail = taskProvider.getemail;
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
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, bottom: 10),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () async {
                            return await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Log out?'),
                                  content: const Text(
                                      'Are you sure you want to log out?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        // deleteData();
                                        Navigator.pushNamed(
                                            context, Routes.login);
                                      },
                                      child: const Text('Yes'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('No'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Icon(
                            Icons.logout_outlined,
                            color: backgroundColor,
                          ),
                        ),
                      ),
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
                            padding: const EdgeInsets.only(
                              left: 10,
                            ),
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
                                        onTap: () async {
                                          //gives double value of same id
                                          // var value = await dialogUtils
                                          //     .showMyDialog(context);
                                          // log('value is $value');
                                          // if (value != null) {
                                          //   setState(() {
                                          //     allTasks.add(value);
                                          //   });
                                          // }

                                          await dialogUtils
                                              .showMyDialog(context);

                                          initializeTask(useEmail).then(
                                              (tasks) => taskProvider
                                                  .updateTasks(tasks));

                                          // setState(() {
                                          //   allTasks = taskData ?? [];
                                          // });
                                          // final taskProvider =
                                          //     Provider.of<TaskProvider>(
                                          //         context,
                                          //         listen: false);
                                          // taskProvider.updateTasks(
                                          //     currentUser?.taskData ?? []);
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
                                TaskList(
                                  allTasks: context
                                      .watch<TaskProvider>()
                                      .allTasks
                                      .where((task) => task.email == useEmail)
                                      .toList(),
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
                                GestureDetector(
                                  onTap: () {},
                                  child: ListTile(
                                    title: Text(
                                      'Water Reminder',
                                      style: headStyle,
                                    ),
                                    trailing: const SwitchButton(
                                      value: 0,
                                      task: 'Water Reminder',
                                      body: 'Please drink the water',
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: ListTile(
                                    title: Text(
                                      'Screen Break',
                                      style: headStyle,
                                    ),
                                    trailing: const SwitchButton(
                                      value: 1,
                                      task: 'Screen Break',
                                      body:
                                          'Please take a break from the screen',
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: ListTile(
                                    title: Text(
                                      'Motivational Quotes',
                                      style: headStyle,
                                    ),
                                    trailing: const SwitchButton(
                                      value: 2,
                                      task: 'Motivational Quotes',
                                      body: 'You are doing great',
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
