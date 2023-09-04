import 'package:daily_remainder/config/routes/app_router.dart';
import 'package:daily_remainder/config/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: const Scaffold(
      //   body: GetStarted(),
      // ),
      debugShowCheckedModeBanner: false,
      theme: themeData,
      onGenerateRoute: AppRouter().ongenerateRoute,
    );
  }
}
