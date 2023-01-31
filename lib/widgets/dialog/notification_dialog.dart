import 'package:commons/commons.dart';
import 'package:finplus/utils/styles.dart';
import 'package:finplus/widgets/button/button.dart';
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
  }) : super(key: key);

  final String title;

  final String description;

  final Function()? onConfirmBtnPressed;

  final Function()? onCancelBtnPressed;

  final String confirmText;

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
            Padding(
              padding: Spaces.t10,
              child: Button(
                child: Text(
                  confirmText,
                ),
                onPressed: onConfirmBtnPressed,
              ),
            ),
            if (showCancelButton)
              Padding(
                padding: Spaces.t10,
                child: TextButton(
                  onPressed: onCancelBtnPressed ?? Get.back,
                  style: TextButton.styleFrom(
                    backgroundColor: theme.backgroundFailLoad,
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: theme.background),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
