import 'package:commons/commons.dart';
import 'package:finplus/providers/auth_provider.dart';
import 'package:finplus/utils/svg.dart';
import 'package:flutter/material.dart';

import '/widgets/button/button.dart';
import '/widgets/text_input/text_input.dart';
import 'login_controller.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (c) => Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            TextInput(controller: c.username),
            TextInput(controller: c.password),
            const Button(
              child: Text('Login'),
            ),
            IconButton(
              onPressed: () => c.login(LoginType.facebook),
              icon: SvgPicture.asset(SvgIcon.fb_icon),
            ),
          ],
        ),
      ),
    );
  }
}
