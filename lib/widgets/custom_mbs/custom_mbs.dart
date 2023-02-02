import 'package:finplus/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomMbs extends StatelessWidget {
  final Widget body;
  final double? height;
  const CustomMbs({super.key, required this.body, this.height});

  @override
  Widget build(BuildContext context) {
    final theme = context.t;
    return SafeArea(
      bottom: false,
      left: false,
      right: false,
      top: true,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: theme.background,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(21),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: Spaces.a10,
              child: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  height: 5,
                  width: 36,
                  decoration: BoxDecoration(
                    color: theme.primary_01,
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
              ),
            ),
            Expanded(child: body),
          ],
        ),
      ),
    );
  }
}
