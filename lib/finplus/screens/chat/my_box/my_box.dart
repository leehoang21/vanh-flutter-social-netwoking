import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/chat/react_button/react_button.dart';
import 'package:finplus/finplus/screens/web_view/web_view_screen.dart';
import 'package:finplus/utils/styles.dart';
import 'package:finplus/utils/svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MyBox extends StatelessWidget {
  final DateTime? diffTime;
  final VoidCallback onDownloadFile;
  final VoidCallback? onDeleteMessage;
  final Function(int)? onReact;
  const MyBox({
    super.key,
    required this.onDownloadFile,
    this.diffTime,
    this.onDeleteMessage,
    this.onReact,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.t;
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: Spaces.a4.copyWith(
        right: 0,
      ),
      child: Column(
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
                  // padding: Spaces.a4,
                  padding: EdgeInsets.zero,
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
                Text(
                  DateFormat('HH:mm').format(
                    DateTime.now(),
                  ),
                  textAlign: TextAlign.right,
                  style: TextDefine.P3_R.copyWith(color: theme.textDisable),
                ),
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
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 14,
                              ),
                              child: _buildContent(),
                            ),
                            //Show if message have react
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
      ),
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
      final Color contentColor = theme.background;
      final Color primaryColor = theme.primaryChat;

      return Container(
        padding: Spaces.h16v10,
        child: Linkify(
          text: 'Nội dung tin nhắn',
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
  //       return Row(
  //         children: [
  //           Spaces.boxW5,
  //           Container(
  //             padding: Spaces.a4,
  //             decoration: BoxDecoration(
  //               color: theme.background,
  //               borderRadius: Decorate.r15,
  //               boxShadow: [
  //                 BoxShadow(
  //                   blurRadius: 1,
  //                   color: theme.shadow,
  //                 ),
  //               ],
  //             ),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: [
  //                 SvgPicture.asset(
  //                   SvgIcon.angry_icon,
  //                   width: 14,
  //                 ),
  //                 Spaces.boxW2,
  //                 SvgPicture.asset(
  //                   SvgIcon.angry_icon,
  //                   width: 14,
  //                 ),
  //                 Spaces.boxW5,
  //                 const Text(
  //                   '0',
  //                   style: TextDefine.P3_R,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

}
