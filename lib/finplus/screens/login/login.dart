import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (c) => Scaffold(
        appBar: AppBar(),
      ),
    );
  }
}
