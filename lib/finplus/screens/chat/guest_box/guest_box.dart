import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/chat/react_button/react_button.dart';
import 'package:finplus/models/login_info_data.dart';
import 'package:finplus/utils/styles.dart';
import 'package:finplus/utils/svg.dart';
import 'package:finplus/utils/utils.dart';
import 'package:finplus/widgets/avatar/avatar.dart';
import 'package:finplus/widgets/drag_reply/drag_reply.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';

import '../../../../providers/chat_provider/models/chat_message_data.dart';

class GuestBox extends StatelessWidget {
  final DateTime? diffTime;
  final VoidCallback onDownloadFile;
  final VoidCallback? onDragReply;
  final RxChatMessageData data;
  final Function(int)? onReact;
  final bool isSameUser;
  final UserInfo? userInfo;

  const GuestBox({
    super.key,
    required this.onDownloadFile,
    this.diffTime,
    this.onReact,
    this.onDragReply,
    required this.data,
    this.isSameUser = false,
    this.userInfo,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.t;

    return Column(
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
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isSameUser)
                Spaces.box32
              else
                Avatar(
                  value: userInfo?.avatar ?? '',
                  size: 32,
                ),
              Spaces.boxW10,
              // if(message had deleted)
              // Container(
              //   padding: Spaces.h16v10,
              //   child: Text(
              //     'Message had been deleted',
              //     style: TextStyle(color: context.t.textDisable),
              //   ),
              //   decoration: BoxDecoration(
              //     color: context.t.backgroundFailLoad,
              //     borderRadius: Decorate.boxChatR,
              //   ),
              // )
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!isSameUser)
                      Text(
                        userInfo?.displayName ?? 'User',
                        textAlign: TextAlign.right,
                        style:
                            TextDefine.P3_R.copyWith(color: theme.textDisable),
                      )
                    else
                      Spaces.box4,
                    DragReply(
                      onDragMaxExpand: onDragReply,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  padding: Spaces.h16v10,
                                  child: _buildContent(),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: theme.primary_04,
                                      width: 1,
                                    ),
                                    borderRadius: Decorate.boxChatR,
                                  ),
                                ),

                                //Show if message have react
                                // Positioned(
                                //   bottom: 0,
                                //   left: 0,
                                //   child: _buildReactOfMessage(),
                                // ),
                              ],
                            ),
                          ),
                          Spaces.boxW5,
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
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    // if (isFile) return _buildFile(context);
    // if (isImage) return _buildImage();
    return _buildTextBox();
  }

  Widget _buildTextBox() {
    switch (data.type) {
      case MESSAGE_TYPE.MESSAGE_REMOVED:
        return Builder(builder: (context) {
          return Text(
            'Tin nhắn đã bị thu hồi',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: context.t.textDisable,
            ),
          );
        });

      default:
    }

    return Linkify(
      text: data.content,
      onOpen: (link) {
        Utils.launchUrl(link.url);
      },
      linkStyle: const TextStyle(
        fontStyle: FontStyle.italic,
        color: Colors.blueAccent,
      ),
    );
  }

  // Widget _buildImage() {
  //   return const ClipRRect(
  //     borderRadius: Decorate.boxChatR,
  //     child: ImageBox(images: []),
  //   );
  // }

  // Widget _buildFile() {
  //   return Builder(
  //     builder: (context) {
  //       return ClipRRect(
  //         borderRadius: Decorate.boxChatR,
  //         child: FileBox(
  //           onDownloadFile: onDownloadFile,
  //           contentColor: context.t.textContent,
  //           backgroundColor: context.t.background,
  //         ),
  //       );
  //     }
  //   );
  // }

  // Widget _buildReactOfMessage() {
  //   return Builder(builder: (context) {
  //     final theme = context.t;
  //     return Row(
  //       children: [
  //         Container(
  //           padding: Spaces.a4,
  //           decoration: BoxDecoration(
  //             color: context.t.background,
  //             borderRadius: Decorate.r15,
  //             boxShadow: [
  //               BoxShadow(
  //                 blurRadius: 1,
  //                 color: theme.shadow,
  //               ),
  //             ],
  //           ),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               SvgPicture.asset(
  //                 SvgIcon.angry_icon,
  //                 width: 14,
  //               ),
  //               Spaces.boxW2,
  //               SvgPicture.asset(
  //                 SvgIcon.angry_icon,
  //                 width: 14,
  //               ),
  //               Spaces.boxW5,
  //               const Text(
  //                 '0',
  //                 style: TextDefine.P3_R,
  //               ),
  //             ],
  //           ),
  //         ),
  //         Spaces.boxW5,
  //       ],
  //     );
  //   });
  // }
}
