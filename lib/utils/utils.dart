import 'package:commons/commons.dart';
import 'package:flutter/cupertino.dart';

class Utils {
  static void showNotification() {
    Get.rawSnackbar(
      // backgroundColor: Colors.white,
      snackPosition: SnackPosition.TOP,
      borderRadius: 8,
      // margin: const EdgeInsets.all(8),

      messageText: const Text('data'),
    );
  }
}
