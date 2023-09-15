import 'dart:developer';
import 'package:daily_remainder/config/routes/routes.dart';
import 'package:daily_remainder/core/colors.dart';
import 'package:daily_remainder/core/constant.dart';
import 'package:daily_remainder/core/textStyle.dart';
import 'package:daily_remainder/features/button.dart';
import 'package:daily_remainder/features/ellipse.dart';
import 'package:daily_remainder/features/inputbox.dart';
import 'package:daily_remainder/storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _conpassword = TextEditingController();
  final _key = GlobalKey<FormState>();

  bool _obscureText = true;
  bool _obscureTextConfirm = true;

  void _update() {
    log('Hello');
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _updateconfirm() {
    log('Hello');
    setState(() {
      _obscureTextConfirm = !_obscureTextConfirm;
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
                        'Welcome Onboard',
                        style: headingStyle,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Let\'s help you meet up your task',
                        style: textStyle,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InputTextBox(
                        hintText: 'Enter your name',
                        inputType: TextInputType.name,
                        controller: _name,
                        obscureText: false,
                        error: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your name';
                          } else if (value!.length <= 8) {
                            return 'Not enough characters';
                          }
                          return null;
                        },
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
                      // context.read<TaskProvider>(),
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
                      InputTextBox(
                        hintText: 'Confirm password',
                        inputType: TextInputType.visiblePassword,
                        controller: _conpassword,
                        obscureText: _obscureTextConfirm,
                        icon: _obscureTextConfirm
                            ? Icons.visibility_off
                            : Icons.visibility,
                        iconTap: () => _updateconfirm(),
                        error: (value) {
                          if (_password.text != value) {
                            return 'Please re-check your password';
                          }
                          return null;
                        },
                      ),
                      // context.read<TaskProvider>().setEmail(_email.text),
                      const SizedBox(
                        height: 60,
                      ),
                      ButtonTap(
                        text: 'Register',
                        onTap: () {
                          if (_key.currentState?.validate() ?? false) {
                            addRegisterData(_email.text, _password.text);
                            navigationKey.currentState?.pushNamed(Routes.login);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: bottomTextStyle,
                          children: [
                            TextSpan(
                              text: 'Sign in',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, Routes.login);
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
