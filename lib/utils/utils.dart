import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/webview/webview.dart';
import 'package:finplus/routes/finplus_routes.dart';
import 'package:finplus/widgets/dialog/notification_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
    VoidCallback? onConfirmBtnPressed,
    bool showCancelButton = false,
    bool barrierDismissible = true,
    String icon = '',
  }) =>
      Get.dialog(
        barrierDismissible: barrierDismissible,
        NotificationDialog(
          confirmText: confirmText ?? 'Confirm',
          onConfirmBtnPressed: onConfirmBtnPressed,
          description: description ?? 'Description',
          title: title ?? 'Notification',
          showCancelButton: showCancelButton,
        ),
      );

  static Future<void> launchUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      if (url.startsWith('http') || url.startsWith('https')) {
        Get.toNamed(
          Routes.webview,
          arguments: WebViewArgument(
            url: url,
          ),
        );
      } else {
        await launchUrlString(url);
      }
    } else {
      logD('Can\'t launch url');
    }
  }

  static Future<String?> pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: source);
    return image?.path;
  }

  static Future<List<String>> pickMultipleImages() async {
    final ImagePicker _picker = ImagePicker();

    final pickedImages =
        await _picker.pickMultiImage(requestFullMetadata: false);
    final List<String> imagesPath = [];

    if (pickedImages.isNotEmpty) {
      imagesPath.addAll(pickedImages.map((e) => e.path));
    }
    return imagesPath;
  }
}

extension LogExtension on Object {
  void logEx([StackTrace? stackTrace]) => logE(this, stackTrace);
}
