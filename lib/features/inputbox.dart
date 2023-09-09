import 'package:flutter/material.dart';
import '../core/colors.dart';

class InputTextBox extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType inputType;
  final VoidCallback? onTap;
  final String? Function(String?)? error;
  final bool obscureText;
  final IconData? icon;
  final VoidCallback? iconTap;
  final bool? isCollapsed;
  final bool? isSmall;
  final bool? readOnly;
  final Function()? onChanged;

  const InputTextBox({
    super.key,
    this.controller,
    required this.inputType,
    required this.hintText,
    this.onTap,
    this.error,
    required this.obscureText,
    this.icon,
    this.iconTap,
    this.isCollapsed,
    this.isSmall,
    this.readOnly,
    this.onChanged,
  });

  @override
  State<InputTextBox> createState() => _TextBoxState();
}

class _TextBoxState extends State<InputTextBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.isSmall ?? true
          ? const EdgeInsets.fromLTRB(20, 10, 20, 10)
          : const EdgeInsets.all(4),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            validator: widget.error,
            onTap: () {
              if (widget.onTap != null) {
                widget.onTap!();
              }
            },
            //onChanged: widget.onChanged,
            controller: widget.controller,
            keyboardType: widget.inputType,
            obscureText: widget.obscureText,
            readOnly: widget.readOnly ?? false,
            decoration: InputDecoration(
              suffixIcon: widget.icon != null
                  ? GestureDetector(
                      onTap: () {
                        if (widget.iconTap != null) {
                          widget.iconTap!();
                        }
                      },
                      child: Icon(widget.icon),
                    )
                  : null,
              filled: true,
              fillColor: textBoxColor,
              hintText: widget.hintText,

              //hintStyle: hintTextStyle,
              contentPadding: widget.isSmall ?? true
                  ? const EdgeInsets.fromLTRB(30, 20, 20, 20)
                  : const EdgeInsets.symmetric(horizontal: 8),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: const BorderSide(color: textBoxColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: const BorderSide(color: textBoxColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: const BorderSide(color: textBoxColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: const BorderSide(color: textBoxColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
