import 'dart:math';

import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/chat/file_box.dart/file_box.dart';
import 'package:finplus/finplus/screens/chat/image_box/image_box.dart';
import 'package:finplus/finplus/screens/web_view/web_view_screen.dart';
import 'package:finplus/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MyBox extends StatelessWidget {
  final DateTime? diffTime;
  final VoidCallback onDownloadFile;
  final VoidCallback onDeleteMessage;
  const MyBox({
    super.key,
    required this.onDownloadFile,
    this.diffTime,
    required this.onDeleteMessage,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDeleted = Random().nextBool();

    return Padding(
      padding: Spaces.a10.copyWith(
        left: 20,
      ),
      child: Column(
        children: [
          if (diffTime != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Text(
                DateFormat('HH:mm dd/MM/yyyy').format(diffTime!),
                style: TextStyle(
                  fontSize: 12,
                  color: context.t.textDisable,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          Container(
            alignment: Alignment.centerRight,
            child: isDeleted
                ? Container(
                    padding: Spaces.h16v10,
                    child: Text(
                      'Message had been deleted',
                      style: TextStyle(color: context.t.textDisable),
                    ),
                    decoration: BoxDecoration(
                      color: context.t.backgroundFailLoad,
                      borderRadius: Decorate.boxChatR,
                    ),
                  )
                : Slidable(
                    closeOnScroll: true,
                    endActionPane: ActionPane(
                      extentRatio: 0.26,
                      motion: const ScrollMotion(),
                      children: [
                        const Spacer(),
                        ClipRRect(
                          borderRadius: Decorate.r50,
                          child: IconButton(
                            onPressed: onDeleteMessage,
                            icon: Icon(
                              CupertinoIcons.delete,
                              color: context.t.background,
                            ),
                          ),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          DateFormat('HH:mm').format(
                            DateTime.now(),
                          ),
                          textAlign: TextAlign.right,
                          style: TextDefine.P3_R
                              .copyWith(color: context.t.textDisable),
                        ),
                        Spaces.boxW10,
                        Flexible(child: _buildContent(context)),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    // if (isFile) return _buidFile();
    // if (isImage) return _buidImage();
    return _buildTextBox(context);
  }

  Widget _buildTextBox(BuildContext context) {
    final Color contentColor = context.t.background;
    final Color primaryColor = context.t.primaryChat;
    return Container(
      padding: Spaces.h16v10,
      child: Linkify(
        text: '',
        style: TextStyle(color: contentColor),
        onOpen: (link) async {
          if (await canLaunchUrlString(link.url)) {
            Get.to(() => WebViewScreen(url: link.url));
          }
        },
        linkStyle: TextStyle(
          fontStyle: FontStyle.italic,
          color: contentColor,
        ),
      ),
      decoration: BoxDecoration(
        color: primaryColor,
        border: Border.all(
          color: primaryColor,
          width: 1,
        ),
        borderRadius: Decorate.boxChatR,
      ),
    );
  }

  Widget _buidImage() {
    return const ClipRRect(
      borderRadius: Decorate.boxChatR,
      child: ImageBox(images: []),
    );
  }

  Widget _buidFile() {
    return ClipRRect(
      borderRadius: Decorate.boxChatR,
      child: FileBox(
        onDownloadFile: onDownloadFile,
      ),
    );
  }
}
