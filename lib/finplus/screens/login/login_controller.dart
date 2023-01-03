import 'package:finplus/providers/auth_provider.dart';
import 'package:finplus/routes/finplus_routes.dart';
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

  Future<void> login(LoginType type) async {
    final res = await _authProvider.login(type: type);

    if (res != null) {
      Get.toNamed(Routes.home);
    }
  }

  @override
  void onClose() {
    username.dispose();
    password.dispose();
    super.onClose();
  }
}
