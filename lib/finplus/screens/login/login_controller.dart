import 'package:finplus/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late final AuthProvider _authProvider;

  late final TextEditingController username;

  late final TextEditingController password;

  @override
  void onInit() {
    _authProvider = AuthProvider();

    username = TextEditingController();

    password = TextEditingController();

    super.onInit();
  }

  void login(LoginType type) {
    _authProvider.login(type: type);
  }

  @override
  void onClose() {
    username.dispose();
    password.dispose();
    super.onClose();
  }
}
