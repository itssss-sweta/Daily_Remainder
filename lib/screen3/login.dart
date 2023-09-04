import 'package:daily_remainder/config/routes/routes.dart';
import 'package:daily_remainder/core/colors.dart';
import 'package:daily_remainder/core/textStyle.dart';
import 'package:daily_remainder/features/button.dart';
import 'package:daily_remainder/features/ellipse.dart';
import 'package:daily_remainder/features/inputbox.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _key = GlobalKey<FormState>();

  bool _obscureText = true;

  void _update() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: Form(
            key: _key,
            child: Stack(
              children: [
                const Ellipse(
                  color: ellipseColor,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Welcome Back',
                        style: headingStyle,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        'images/login.png',
                        height: 159,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InputTextBox(
                        hintText: 'Enter your email',
                        inputType: TextInputType.emailAddress,
                        controller: _email,
                        obscureText: false,
                        error: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your email';
                          } else if (!RegExp(r'^\S+@\S+\.\S+')
                              .hasMatch(value ?? '')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      InputTextBox(
                        hintText: 'Enter password',
                        inputType: TextInputType.visiblePassword,
                        controller: _password,
                        obscureText: _obscureText,
                        icon: _obscureText
                            ? Icons.visibility_off
                            : Icons.visibility,
                        iconTap: () => _update(),
                        error: (value) {
                          if (value!.isEmpty || value.length <= 10) {
                            return 'Please enter a password of length 10 or more';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      ButtonTap(
                        text: 'Login',
                        onTap: () {
                          if (_key.currentState?.validate() ?? false) {
                            Navigator.pushNamed(context, Routes.home);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Don\'t have an account? ',
                          style: bottomTextStyle,
                          children: [
                            TextSpan(
                              text: 'Sign up',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, Routes.register);
                                },
                              style: linkTextStyle,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
