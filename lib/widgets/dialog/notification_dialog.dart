import 'package:commons/commons.dart';
import 'package:finplus/utils/styles.dart';
import 'package:flutter/material.dart';

class NotificationDialog extends StatelessWidget {
  const NotificationDialog({
    Key? key,
    this.title = 'Notification',
    this.description = 'Description',
    this.confirmText = 'Confirm',
    this.onConfirmBtnPressed,
    this.showCancelButton = false,
    this.onCancelBtnPressed,
    this.cancelText = 'Cancel',
  }) : super(key: key);

  final String title;

  final String description;

  final VoidCallback? onConfirmBtnPressed;

  final VoidCallback? onCancelBtnPressed;

  final String confirmText;
  final String cancelText;

  final bool showCancelButton;

  @override
  Widget build(BuildContext context) {
    final theme = context.t;
    return Dialog(
      child: Padding(
        padding: Spaces.a16,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextDefine.H2_B,
            ),
            Spaces.box16,
            Text(
              description,
              style: TextDefine.P1_R.copyWith(
                color: context.t.textContent,
              ),
              textAlign: TextAlign.center,
            ),
            Row(
              children: [
                if (showCancelButton)
                  Expanded(
                    child: Padding(
                      padding: Spaces.t10,
                      child: TextButton(
                        onPressed: onCancelBtnPressed ?? Get.back,
                        style: TextButton.styleFrom(
                          backgroundColor: theme.backgroundFailLoad,
                        ),
                        child: Text(
                          cancelText,
                          style: TextStyle(color: theme.background),
                        ),
                      ),
                    ),
                  ),
                Spaces.box16,
                if (onConfirmBtnPressed != null)
                  Expanded(
                    child: Padding(
                      padding: Spaces.t10,
                      child: TextButton(
                        onPressed: onConfirmBtnPressed ?? Get.back,
                        style: TextButton.styleFrom(
                          backgroundColor: theme.secondary_02,
                        ),
                        child: Text(
                          confirmText,
                          style: TextStyle(color: theme.background),
                        ),
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
