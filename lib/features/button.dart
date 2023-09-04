import 'dart:developer';
import 'package:daily_remainder/core/colors.dart';
import 'package:daily_remainder/core/constant.dart';
import 'package:daily_remainder/core/textStyle.dart';
import 'package:flutter/material.dart';

class ButtonTap extends StatelessWidget {
  final String text;
  final Function onTap;
  const ButtonTap({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log('4');
        onTap();
      },
      child: Container(
        height: 60,
        width: 321,
        decoration: const BoxDecoration(
          color: buttonColor,
        ),
        margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Padding(
          padding: buttonPadding,
          child: Text(
            text,
            style: buttonTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
