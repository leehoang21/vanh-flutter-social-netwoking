import 'package:commons/commons.dart';
import 'package:finplus/widgets/dialog/notification.dialog.dart';
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

  static Future showDialog({
    String? title,
    dynamic description,
    String? confirmText,
    dynamic Function()? onConfirmBtnPressed,
    Color? affirmativeBtnColor,
    bool showCancelButton = false,
    bool barrierDismissible = true,
    String icon = '',
  }) =>
      Get.dialog(
        barrierDismissible: barrierDismissible,
        NotificationDialog(
          affirmativeBtnColor: affirmativeBtnColor,
          confirmText: confirmText,
          onConfirmBtnPressed: onConfirmBtnPressed,
          description: description ?? 'description',
          title: title ?? 'Notification',
          showCancelButton: showCancelButton,
        ),
      );
}

extension LogExtension on Object {
  void logEx([StackTrace? stackTrace]) => logE(this, stackTrace);
}
