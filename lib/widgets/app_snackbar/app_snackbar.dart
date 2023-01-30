import 'package:finplus/utils/styles.dart';
import 'package:flutter/material.dart';

class AppSnackBar extends StatelessWidget {
  final String content;
  const AppSnackBar({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      padding: const EdgeInsets.all(8),
      child: Text(
        content,
        style: TextDefine.P2_M.copyWith(color: Colors.white),
      ),
    );
  }
}
