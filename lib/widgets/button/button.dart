import 'package:finplus/utils/styles.dart';
import 'package:flutter/material.dart';

enum ButtonType { plat, gradient }

class Button extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonType type;
  final Gradient? gradient;
  const Button(
      {super.key,
      this.onPressed,
      required this.child,
      this.type = ButtonType.plat,
      this.gradient});

  @override
  Widget build(BuildContext context) {
    final theme = context.t;

    switch (type) {
      case ButtonType.gradient:
        return SizedBox(
          height: 48,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: onPressed != null
                  ? gradient ??
                      LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            theme.secondary_02 ?? Colors.transparent,
                            theme.secondary_01 ?? Colors.transparent
                          ])
                  : null,
            ),
            child: TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
                disabledBackgroundColor: theme.secondary_01?.withOpacity(0.4),
                disabledForegroundColor: Colors.white,
              ),
              child: child,
            ),
          ),
        );
      default:
    }

    return SizedBox(
      height: 48,
      child: TextButton(onPressed: onPressed, child: child),
    );
  }
}