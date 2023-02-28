import 'package:finplus/utils/styles.dart';
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController? controller;

  const TextInput({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = context.t;
    return SizedBox(
      height: 48,
      child: TextFormField(
        style: TextDefine.P1_R.copyWith(color: Colors.white),
        decoration: const InputDecoration(),
        key: key,
        controller: controller,
      ),
    );
  }
}
