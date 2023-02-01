import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/chat/react_button/react_button.dart';
import 'package:finplus/finplus/screens/web_view/web_view_screen.dart';
import 'package:finplus/utils/styles.dart';
import 'package:finplus/utils/svg.dart';
import 'package:finplus/widgets/avatar/avatar.dart';
import 'package:finplus/widgets/drag_reply/drag_reply.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GuestBox extends StatelessWidget {
  final DateTime? diffTime;
  final VoidCallback onDownloadFile;
  final VoidCallback? onDragReply;
  final Function(int)? onReact;

  const GuestBox({
    super.key,
    required this.onDownloadFile,
    this.diffTime,
    this.onReact,
    this.onDragReply,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.t;

    return Padding(
      padding: Spaces.a4.copyWith(
        right: 10,
        left: 0,
      ),
      child: Column(
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
          DragReply(
            onDragMaxExpand: onDragReply,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Avatar(
                    url: '',
                    size: 30,
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
                        Text(
                          'Tên, ${DateFormat('HH:mm').format(DateTime.now())}',
                          textAlign: TextAlign.right,
                          style: TextDefine.P3_R
                              .copyWith(color: theme.textDisable),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 14,
                                    ),
                                    child: _buildContent(),
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
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    // if (isFile) return _buildFile(context);
    // if (isImage) return _buildImage();
    return _buildTextBox();
  }

  Widget _buildTextBox() {
    return Builder(builder: (context) {
      final Color primaryChat = context.t.primaryChat;
      return Container(
        padding: Spaces.h16v10,
        child: Linkify(
          text: 'Nội dung tin nhắn',
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
    });
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
