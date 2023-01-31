import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/chat/file_box.dart/file_box.dart';
import 'package:finplus/finplus/screens/chat/image_box/image_box.dart';
import 'package:finplus/finplus/screens/web_view/web_view_screen.dart';
import 'package:finplus/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

const double _sizeAvatar = 30;

class GuestBox extends StatelessWidget {
  final DateTime? diffTime;
  final VoidCallback onDownloadFile;

  const GuestBox({
    super.key,
    required this.onDownloadFile,
    this.diffTime,
  });

  @override
  Widget build(BuildContext context) {
    final Color primaryChat = context.t.primaryChat;
    final bool isDeleted = Random().nextBool();

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
                borderRadius: Decorate.avatarR,
                child: CachedNetworkImage(
                  imageUrl: '',
                  color: primaryChat,
                  errorWidget: (context, url, error) {
                    return Container(
                      width: _sizeAvatar,
                      height: _sizeAvatar,
                      color: primaryChat,
                      child: Icon(
                        CupertinoIcons.person_alt_circle,
                        size: _sizeAvatar,
                        color: context.t.background,
                      ),
                    );
                  },
                  fit: BoxFit.cover,
                  width: _sizeAvatar,
                  height: _sizeAvatar,
                ),
              ),
              Spaces.boxW10,
              if (isDeleted)
                Container(
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
              else
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        child: _buildContent(context),
                      ),
                      Spaces.boxW10,
                      Text(
                        DateFormat('HH:mm').format(DateTime.now()),
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

  Widget _buildContent(BuildContext context) {
    // if (isFile) return _buidFile(context);
    // if (isImage) return _buidImage();
    return _buildTextBox(context);
  }

  Widget _buildTextBox(BuildContext context) {
    final Color primaryChat = context.t.primaryChat;
    return Container(
      padding: Spaces.h16v10,
      child: Linkify(
        text: '',
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

  Widget _buidFile(BuildContext context) {
    return ClipRRect(
      borderRadius: Decorate.boxChatR,
      child: FileBox(
        onDownloadFile: onDownloadFile,
        contentColor: context.t.textContent,
        backgroundColor: context.t.background,
      ),
    );
  }
}
