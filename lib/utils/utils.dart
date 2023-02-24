import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/webview/webview.dart';
import 'package:finplus/routes/finplus_routes.dart';
import 'package:finplus/utils/styles.dart';
import 'package:finplus/utils/svg.dart';
import 'package:finplus/widgets/dialog/notification_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
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

  static KeyboardActionsConfig buildKeyBoardConfig(
    BuildContext context,
    FocusNode focusNode,
    void Function(List<String> images) pickImage,
    void Function() onTapDone
  ) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          displayArrows: false,
          toolbarAlignment: MainAxisAlignment.start,
          focusNode: focusNode,
          toolbarButtons: [
            (node) {
              return Row(
                children: [
                  Spaces.box24,
                  InkWell(
                    child: SizedBox(
                      width: 22,
                      height: 22,
                      child: SvgPicture.asset(SvgIcon.choose_stocks),
                    ),
                    onTap: () {},
                  ),
                  Spaces.box16,
                  InkWell(
                      child: SizedBox(
                        width: 22,
                        height: 22,
                        child: SvgPicture.asset(SvgIcon.emojis),
                      ),
                      onTap: () async {
                        final result = await Utils.pickMultipleImages();
                        pickImage(result);
                      }),
                  Spaces.box16,
                  InkWell(
                    child: SizedBox(
                      width: 22,
                      height: 22,
                      child: SvgPicture.asset(SvgIcon.image),
                    ),
                    onTap: () {},
                  ),
                  Spaces.box16,
                  InkWell(
                    child: SizedBox(
                      width: 22,
                      height: 22,
                      child: SvgPicture.asset(SvgIcon.camera),
                    ),
                    onTap: () {},
                  ),
                ],
              );
            },
            (n) {
              return const Spacer();
            },
            (m) {
              return Row(
                children: [
                  InkWell(
                    child: const SizedBox(
                      width: 22,
                      height: 22,
                      child: Icon(Icons.send),
                    ),
                    onTap: onTapDone,
                  ),
                  Spaces.box20
                ],
              );
            }
          ],
        ),
      ],
    );
  }
}

extension LogExtension on Object {
  void logEx([StackTrace? stackTrace]) => logE(this, stackTrace);
}
