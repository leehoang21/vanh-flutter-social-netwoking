import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/chat/react_button/react_button.dart';
import 'package:finplus/providers/chat_provider/models/chat_message_data.dart';
import 'package:finplus/utils/styles.dart';
import 'package:finplus/utils/svg.dart';
import 'package:finplus/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class MyBox extends StatelessWidget {
  final RxChatMessageData data;
  final DateTime? diffTime;
  final VoidCallback onDownloadFile;
  final VoidCallback? onDeleteMessage;
  final Function(int)? onReact;
  final bool isSameUser;

  const MyBox({
    super.key,
    required this.onDownloadFile,
    this.diffTime,
    this.onDeleteMessage,
    this.onReact,
    required this.data,
    this.isSameUser = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.t;
    final size = MediaQuery.of(context).size;

    if (data.type == MESSAGE_TYPE.USER_JOINED)
      return Container(
        padding: Spaces.v8,
        alignment: Alignment.center,
        child: Text(
          'Bạn đã tham gia nhóm chat',
          style: TextStyle(color: theme.textDisable),
        ),
      );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (diffTime != null)
          Row(
            children: [
              const Expanded(child: Divider(height: 1)),
              Padding(
                padding: Spaces.h8v16,
                child: Text(
                  DateFormat('HH:mm dd/MM/yyyy').format(diffTime!),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.textDisable,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const Expanded(child: Divider(height: 1)),
            ],
          ),
        Slidable(
          closeOnScroll: true,
          enabled: onDeleteMessage != null,
          endActionPane: ActionPane(
            extentRatio: 44 / (size.width - 16),
            motion: const ScrollMotion(),
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: Decorate.r50,
                ),
                child: IconButton(
                  onPressed: onDeleteMessage,
                  icon: Icon(
                    CupertinoIcons.delete,
                    size: 14,
                    color: theme.background,
                  ),
                ),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (onReact != null)
                      ReactButton(
                        onReact: onReact!,
                        icon: SvgPicture.asset(
                          SvgIcon.fun_icon,
                          color: theme.textDisable,
                        ),
                        dimension: 20,
                      ),
                    Spaces.boxW5,
                    Flexible(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            margin: isSameUser
                                ? const EdgeInsets.only(top: 4)
                                : null,
                            decoration: BoxDecoration(
                              color: theme.primary_04.withOpacity(0.5),
                              border: Border.all(
                                color: theme.primary_04,
                                width: 1,
                              ),
                              borderRadius: Decorate.boxChatR,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: Spaces.h16v10.copyWith(bottom: 4),
                                  child: _buildContent(),
                                ),
                                Padding(
                                  padding: Spaces.h16.copyWith(bottom: 8),
                                  child: Text(
                                    Commons.formatDateToDisplay(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          data.createdAt),
                                      'HH:mm',
                                    ),
                                    style: TextDefine.P4_R
                                        .copyWith(color: theme.textDisable),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Show if message have react
                          // Positioned(
                          //   bottom: 0,
                          //   right: 0,
                          //   child: _buildReactOfMessage(),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    // if (isFile) return _buildFile();
    // if (isImage) return _buildImage();
    return _buildTextBox();
  }

  Widget _buildTextBox() {
    return Builder(builder: (context) {
      final theme = context.t;
      if (data.type == MESSAGE_TYPE.MESSAGE_REMOVED) {
        return Text(
          'Tin nhắn đã bị thu hồi',
          style:
              TextStyle(fontStyle: FontStyle.italic, color: theme.textDisable),
        );
      }

      return Linkify(
        text: data.content,
        onOpen: (link) => Utils.launchUrl(link.url),
        linkStyle: TextStyle(
          fontStyle: FontStyle.italic,
          color: theme.background,
        ),
      );
    });
  }

  // Widget _buildImage() {
  //   return const ClipRRect(
  //     borderRadius: Decorate.boxChatR,
  //     child: ImageBox(images: []),
  //   );
  // }

  // Widget _buildFile() {
  //   return ClipRRect(
  //     borderRadius: Decorate.boxChatR,
  //     child: FileBox(
  //       onDownloadFile: onDownloadFile,
  //     ),
  //   );
  // }

  // Widget _buildReactOfMessage() {
  //   return Builder(
  //     builder: (context) {
  //       final theme = context.t;
  //       return GestureDetector(
  //         onTap: () => Get.bottomSheet(
  //           const UserReactMbs(),
  //           isScrollControlled: true,
  //           ignoreSafeArea: false,
  //         ),
  //         child: Row(
  //           children: [
  //             Spaces.boxW5,
  //             Container(
  //               padding: Spaces.a4,
  //               decoration: BoxDecoration(
  //                 color: theme.background,
  //                 borderRadius: Decorate.r15,
  //                 boxShadow: [
  //                   BoxShadow(
  //                     blurRadius: 1,
  //                     color: theme.shadow,
  //                   ),
  //                 ],
  //               ),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 children: [
  //                   SvgPicture.asset(
  //                     SvgIcon.angry_icon,
  //                     width: 14,
  //                   ),
  //                   Spaces.boxW2,
  //                   SvgPicture.asset(
  //                     SvgIcon.angry_icon,
  //                     width: 14,
  //                   ),
  //                   Spaces.boxW5,
  //                   const Text(
  //                     '0',
  //                     style: TextDefine.P3_R,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
