import 'package:daily_remainder/alert/notification.dart';
import 'package:daily_remainder/config/routes/app_router.dart';
import 'package:daily_remainder/config/theme.dart';
import 'package:daily_remainder/core/constant.dart';
import 'package:daily_remainder/storage.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

NotificationsService notificationsService = NotificationsService();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  initializeCredentials();
  // initializeLoginInfo();
  // initalizeTask();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigationKey,
      // home: const Scaffold(
      //   body: GetStarted(),
      // ),
      debugShowCheckedModeBanner: false,
      theme: themeData,
      onGenerateRoute: AppRouter().ongenerateRoute,
    );
  }
}
