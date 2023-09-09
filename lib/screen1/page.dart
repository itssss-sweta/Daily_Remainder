import 'package:daily_remainder/config/routes/routes.dart';
import 'package:daily_remainder/core/colors.dart';
import 'package:daily_remainder/core/constant.dart';
import 'package:daily_remainder/core/textStyle.dart';
import 'package:daily_remainder/features/button.dart';
import 'package:daily_remainder/features/ellipse.dart';
import 'package:flutter/material.dart';
import '../storage.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: colpadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/getstarted.png',
                      height: 146,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'Get things done with Reminder',
                  style: headingStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras quis leo libero lectus. Vitae consectetur vitae nullam urna tellus purus, est nisl. Gravida volutpat nec adipiscing commodo ultricies nunc libero. Est sem mauris turpis lectus dolor ut nisi mauris sit.',
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 100,
                ),
                ButtonTap(
                  text: 'Get Started',
                  onTap: () {
                    if (retrieveData() != null) {
                      Navigator.pushNamed(context, Routes.home);
                    } else {
                      navigationKey.currentState?.pushNamed(Routes.login);
                    }
                    // Navigator.pushNamed(context, Routes.login);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const RegisterPage(),
                    //   ),
                    // );
                  },
                ),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
          const Ellipse(
            color: ellipseColor,
          ),
        ],
      ),
    );
  }
}
