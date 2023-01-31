import 'package:cached_network_image/cached_network_image.dart';
import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/chat/file_box.dart/file_box.dart';
import 'package:finplus/finplus/screens/chat/image_box/image_box.dart';
import 'package:finplus/finplus/screens/web_view/web_view_screen.dart';
import 'package:finplus/models/chat_data.dart';
import 'package:finplus/models/login_info_data.dart';
import 'package:finplus/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

const double _sizeAvatar = 30;

class GuestBox extends StatelessWidget {
  final RxChatData dataChat;
  final DateTime? diffTime;
  final VoidCallback onDownloadFile;

  const GuestBox({
    super.key,
    required this.dataChat,
    required this.onDownloadFile,
    this.diffTime,
  });

  @override
  Widget build(BuildContext context) {
    final Color primaryChat = context.t.primaryChat;
    return Padding(
      padding: Spaces.a10.copyWith(
        right: 20,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: AppBorderAndRadius.avatarBorderRadius,
                child: CachedNetworkImage(
                  imageUrl: dataChat.userAvatar,
                  color: primaryChat,
                  errorWidget: (context, url, error) {
                    return Container(
                      width: _sizeAvatar,
                      height: _sizeAvatar,
                      color: primaryChat,
                      child: const Icon(
                        CupertinoIcons.person_alt_circle,
                        size: _sizeAvatar,
                      ),
                    );
                  },
                  fit: BoxFit.cover,
                  width: _sizeAvatar,
                  height: _sizeAvatar,
                ),
              ),
              Spaces.boxW10,
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Builder(builder: (context) {
                        if (dataChat.value.resource.isNotEmpty &&
                            dataChat.value.resource.first.urlOrigin != null)
                          return _buidImage();
                        if (dataChat.resource.isNotEmpty)
                          return _buidFile(context);
                        return Container(
                          padding: Spaces.h16v10,
                          child: Linkify(
                            text: dataChat.content,
                            onOpen: (link) async {
                              if (await canLaunchUrlString(link.url)) {
                                Get.to(() => WebViewScreen(url: link.url));
                              }
                            },
                            linkStyle: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: primaryChat,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: primaryChat,
                              width: 1,
                            ),
                            borderRadius:
                                AppBorderAndRadius.boxChatBorderRadius,
                          ),
                        );
                      }),
                    ),
                    Spaces.boxW10,
                    Text(
                      DateFormat('HH:mm').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              int.parse(dataChat.createTime) * 1000)),
                      textAlign: TextAlign.right,
                      style: TextDefine.P3_R
                          .copyWith(color: context.t.textDisable),
                    ),
                  ],
                ),
              )
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

  Widget _buidFile(BuildContext context) {
    return ClipRRect(
      borderRadius: AppBorderAndRadius.boxChatBorderRadius,
      child: FileBox(
        data: dataChat,
        onDownloadFile: onDownloadFile,
        contentColor: context.t.textContent,
        backgroundColor: context.t.background,
      ),
    );
  }
}
