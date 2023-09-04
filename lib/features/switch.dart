import 'package:daily_remainder/core/colors.dart';
import 'package:flutter/material.dart';

class SwitchButton extends StatefulWidget {
  const SwitchButton({super.key});

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  bool dark = true;
  @override
  Widget build(BuildContext context) {
    return Switch(
        value: dark,
        activeColor: buttonColor,
        onChanged: (value) {
          setState(() {
            dark = value;
          });
        });
  }
}
