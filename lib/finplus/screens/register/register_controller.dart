import 'package:commons/commons.dart';
import 'package:flutter/cupertino.dart';

class RegisterController extends GetxController {
  late final TextEditingController email;

  late final TextEditingController password;

  late final TextEditingController name;

  @override
  void onInit() {
    email = TextEditingController();

    password = TextEditingController();

    name = TextEditingController();

    super.onInit();
  }

  @override
  void onClose() {
    email.dispose();

    password.dispose();

    super.onClose();
  }
}
