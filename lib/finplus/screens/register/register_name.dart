import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/register/register_controller.dart';
import 'package:finplus/services/database.dart';
import 'package:flutter/material.dart';

import '../../../routes/finplus_routes.dart';
import '../../../services/auth_service.dart';
import '../../../utils/styles.dart';
import '../../../widgets/button/button.dart';
import '../../../widgets/text_input/text_input.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.t;
    final AuthService _auth = AuthService();

    return GetBuilder<RegisterController>(
      builder: (c) => Scaffold(
        backgroundColor: theme.primary_01,
        body: ListView(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 150,
            ),
            Spaces.box42,
            Text(
              'Đăng ký',
              style: TextDefine.H1_B.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Spaces.box24,
            Padding(
              padding: Spaces.h16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Email:'),
                  Spaces.box6,
                  TextInput(controller: c.email),
                ],
              ),
            ),
            Spaces.box16,
            Padding(
              padding: Spaces.h16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Password:'),
                  Spaces.box6,
                  TextInput(controller: c.password),
                ],
              ),
            ),
            Spaces.box16,
            Padding(
              padding: Spaces.h16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Name:'),
                  Spaces.box6,
                  TextInput(controller: c.name),
                ],
              ),
            ),
            Spaces.box20,
            Padding(
              padding: Spaces.h16,
              child: Button(
                type: ButtonType.gradient,
                onPressed: () async {
                  final dynamic result =
                      await _auth.registerWithEmailAndPassword(
                    c.email.value.text,
                    c.password.value.text,
                  );
                  if (result != null) {
                    await DatabaseService(uid: _auth.user!.uid)
                        .updateUserData(c.name.value.text, _auth.user!.uid);
                  }
                  Get.offAllNamed(Routes.home);
                },
                child: const Text('Đăng ký'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
