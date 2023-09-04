import 'package:flutter/material.dart';

class Ellipse extends StatelessWidget {
  final Color color;
  const Ellipse({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -60,
          left: -50,
          height: 200,
          width: 200,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(.5),
            ),
          ),
        ),
        Positioned(
          top: -105,
          left: 50,
          height: 200,
          width: 200,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(.56),
            ),
          ),
        ),
      ],
    );
  }
}
