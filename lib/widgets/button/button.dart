import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  const Button({super.key, this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: child);
  }
}
