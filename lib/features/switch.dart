import 'package:daily_remainder/core/colors.dart';
import 'package:daily_remainder/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SwitchButton extends StatefulWidget {
  final int value;
  final String task;
  final String body;
  const SwitchButton(
      {super.key, required this.value, required this.task, required this.body});

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SwitchButton1(),
      child: Consumer<SwitchButton1>(builder: (context, model, child) {
        return Switch(
            value: model.button,
            activeColor: buttonColor,
            onChanged: (value) {
              model.button = value;
              if (value == true) {
                notificationsService.scheduleNotification(
                    widget.value, widget.task, widget.body);
              }
            });
      }),
    );
  }
}

class SwitchButton1 extends ChangeNotifier {
  bool _button = true;

  bool get button => _button;

  set button(bool value) {
    _button = value;
    notifyListeners();
  }
}
