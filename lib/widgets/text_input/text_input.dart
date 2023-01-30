import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController? controller;

  const TextInput({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextFormField(
        key: key,
        controller: controller,
      ),
    );
  }
}
