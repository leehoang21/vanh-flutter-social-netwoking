import 'package:finplus/widgets/dialog/notification.dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void _navigateBack() => Get.back(result: false);

class AppDialogs {
  static void hideDialog() => _navigateBack();
  static Future showLoadingCircle() => Get.dialog(
        WillPopScope(
          onWillPop: () async => false,
          child: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Get.width / 3,
                  child: const LinearProgressIndicator(),
                ),
              ],
            ),
          ),
        ),
        barrierDismissible: false,
        routeSettings: const RouteSettings(name: 'loading'),
      );

  static void hideLoadingCircle() => _navigateBack();

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
