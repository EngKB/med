import 'package:flutter/material.dart';

class LGradient extends StatelessWidget {
  final Widget child;
  final double high;

  const LGradient({
    Key? key,
    required this.high,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: high,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff1B4798), Color(0xff5CC3D6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
      child: child,
    );
  }
}
