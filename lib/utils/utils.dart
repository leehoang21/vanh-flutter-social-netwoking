import 'package:commons/commons.dart';
import 'package:flutter/material.dart';

import '/widgets/app_snackbar/app_snackbar.dart';
import 'app_logger.dart';

class Utils {
  static void showNotification(String? content) {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }
    Get.rawSnackbar(
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.zero,
      snackPosition: SnackPosition.TOP,
      messageText: AppSnackBar(content: content?.tr ?? ''),
    );
  }
}

extension LogExtension on Object {
  void logEx([StackTrace? stackTrace]) => logE(this, stackTrace);
}