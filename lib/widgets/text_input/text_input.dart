import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController? controller;

  const TextInput({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      controller: controller,
    );
  }
}
