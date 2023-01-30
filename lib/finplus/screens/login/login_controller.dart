import 'package:commons/loading_overlay/loading_overlay.dart';
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
    final res = await LoadingOverlay.load(_authProvider.login(
      type: type,
      username: username.text,
      password: password.text,
    ));

    if (res != null) {
      Get.offAllNamed(Routes.home);
    }
  }

  @override
  void onClose() {
    username.dispose();
    password.dispose();
    super.onClose();
  }
}
