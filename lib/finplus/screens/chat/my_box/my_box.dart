import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/chat/file_box.dart/file_box.dart';
import 'package:finplus/finplus/screens/chat/image_box/image_box.dart';
import 'package:finplus/finplus/screens/web_view/web_view_screen.dart';
import 'package:finplus/models/chat_data.dart';
import 'package:finplus/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MyBox extends StatelessWidget {
  final RxChatData dataChat;
  final DateTime? diffTime;
  final VoidCallback onDownloadFile;
  final VoidCallback onDeleteMessage;
  const MyBox({
    super.key,
    required this.dataChat,
    required this.onDownloadFile,
    this.diffTime,
    required this.onDeleteMessage,
  });

  @override
  Widget build(BuildContext context) {
    final Color primaryChatColor = context.t.primaryChat;
    final Color contentColor = context.t.background;

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                DateFormat('HH:mm').format(
                  DateTime.fromMillisecondsSinceEpoch(
                    int.parse(dataChat.value.createTime) * 1000,
                  ),
                ),
                textAlign: TextAlign.right,
                style: TextDefine.P3_R.copyWith(color: context.t.textDisable),
              ),
              Spaces.boxW10,
              if (dataChat.value.isDelete)
                Container(
                  padding: Spaces.h16v10,
                  child: Text(
                    'Message had been deleted',
                    style: TextStyle(color: context.t.textDisable),
                  ),
                  decoration: BoxDecoration(
                    color: context.t.backgroundFailLoad,
                    borderRadius: AppBorderAndRadius.boxChatBorderRadius,
                  ),
                )
              else
                Flexible(
                  child: Slidable(
                    closeOnScroll: true,
                    endActionPane: ActionPane(
                      extentRatio: 0.26,
                      motion: const ScrollMotion(),
                      children: [
                        const Spacer(),
                        CircleAvatar(
                          backgroundColor: context.t.primaryChat,
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
                    child: Builder(builder: (context) {
                      if (dataChat.value.resource.isNotEmpty &&
                          dataChat.value.resource.first.urlOrigin != null)
                        return _buidImage();
                      if (dataChat.resource.isNotEmpty) return _buidFile();

                      return Container(
                        padding: Spaces.h16v10,
                        child: Linkify(
                          text: dataChat.content,
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
                          color: primaryChatColor,
                          border: Border.all(
                            color: primaryChatColor,
                            width: 1,
                          ),
                          borderRadius: AppBorderAndRadius.boxChatBorderRadius,
                        ),
                      );
                    }),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buidImage() {
    return ClipRRect(
      borderRadius: AppBorderAndRadius.boxChatBorderRadius,
      child: ImageBox(images: [dataChat.value.resource.first.urlOrigin!]),
    );
  }

  Widget _buidFile() {
    return ClipRRect(
      borderRadius: AppBorderAndRadius.boxChatBorderRadius,
      child: FileBox(
        data: dataChat,
        onDownloadFile: onDownloadFile,
      ),
    );
  }
}
