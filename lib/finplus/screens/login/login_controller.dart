import 'package:finplus/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // ignore: unused_field
  late final AuthProvider _authProvider;

  late final TextEditingController email;

  late final TextEditingController password;

  @override
  void onInit() {
    _authProvider = AuthProvider();

    email = TextEditingController(text: 'phamhieu@gmail.com');

    password = TextEditingController(text: '123456');

    super.onInit();
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }
}
