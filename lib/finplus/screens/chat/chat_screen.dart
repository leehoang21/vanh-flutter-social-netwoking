import 'package:cached_network_image/cached_network_image.dart';
import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/chat/chat_controller.dart';
import 'package:finplus/finplus/screens/chat/guest_box/guest_box.dart';
import 'package:finplus/finplus/screens/chat/my_box/my_box.dart';
import 'package:finplus/models/chat_data.dart';
import 'package:finplus/utils/styles.dart';
import 'package:finplus/widgets/smart_refresh/custom_smart_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.t;

    final InputBorder _borderInputField = OutlineInputBorder(
      borderSide: BorderSide(
        color: theme.primaryChat,
        width: 1,
      ),
      borderRadius: Decorate.r15,
    );

    return GetBuilder<ChatController>(
        init: ChatController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: theme.primaryChat,
              leading: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(CupertinoIcons.chevron_left),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: AppBorderAndRadius.avatarBorderRadius,
                    child: CachedNetworkImage(
                      imageUrl: controller.userChatWith.value?.avatar ?? '',
                      fit: BoxFit.cover,
                      width: 40,
                      height: 40,
                      errorWidget: (context, url, error) => const Icon(
                        CupertinoIcons.person_alt_circle,
                        size: 40,
                      ),
                    ),
                  ),
                  Spaces.box10,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.userChatWith.value?.name ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: TextDefine.T1_R,
                        ),
                        const Text(
                          'Đang online',
                          style: TextDefine.P3_R,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            body: SafeArea(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                  color: theme.background,
                  child: Column(
                    children: [
                      Expanded(
                        child: Obx(
                          () => CustomSmartRefresher(
                            controller: controller.refreshController,
                            onLoading: controller.onLoading,
                            child: ListView.builder(
                              reverse: true,
                              controller: controller.scrollController,
                              itemCount: controller.listChat.value.length,
                              itemBuilder: (context, i) {
                                final chat = controller.listChat.value[i];
                                final RxChatData? nextData =
                                    i + 1 < controller.listChat.value.length
                                        ? controller.listChat.value[i + 1]
                                        : null;

                                DateTime? diffTime;

                                if (nextData != null) {
                                  print(
                                      'day ${DateTime.fromMillisecondsSinceEpoch(int.parse(nextData.createTime) * 1000)}');
                                  if (DateTime.fromMillisecondsSinceEpoch(
                                              int.parse(nextData.createTime) *
                                                  1000)
                                          .difference(DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  int.parse(controller
                                                          .listChat
                                                          .value[i]
                                                          .createTime) *
                                                      1000))
                                          .inHours
                                          .abs() >=
                                      12) {
                                    diffTime =
                                        DateTime.fromMillisecondsSinceEpoch(
                                            int.parse(controller.listChat
                                                    .value[i].createTime) *
                                                1000);
                                  }
                                }

                                if (chat.value.userId == controller.userId) {
                                  return MyBox(
                                    diffTime: diffTime,
                                    dataChat: chat,
                                    onDownloadFile: () =>
                                        controller.downloadFile(chat),
                                    onDeleteMessage: () =>
                                        controller.deleteMessage(chat),
                                  );
                                } else {
                                  return GuestBox(
                                    diffTime: diffTime,
                                    dataChat: chat,
                                    onDownloadFile: () =>
                                        controller.downloadFile(chat),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: Spaces.v10,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              width: 1,
                              color: theme.primaryChat,
                            ),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Obx(
                              () => controller.onExpandedInputField.value
                                  ? IconButton(
                                      onPressed: () => controller
                                              .onExpandedInputField.value =
                                          !controller
                                              .onExpandedInputField.value,
                                      icon: Icon(
                                        CupertinoIcons.chevron_right,
                                        color: theme.primaryChat,
                                      ),
                                    )
                                  : Row(
                                      children: [
                                        IconButton(
                                          onPressed: controller.takePhoto,
                                          icon: Icon(
                                              CupertinoIcons.photo_camera,
                                              color: theme.primaryChat),
                                        ),
                                        IconButton(
                                          onPressed:
                                              controller.selectImageFromLib,
                                          icon: Icon(CupertinoIcons.photo,
                                              color: theme.primaryChat),
                                        ),
                                        IconButton(
                                          onPressed: controller.pickFile,
                                          icon: Icon(
                                              CupertinoIcons.arrow_up_doc,
                                              color: theme.primaryChat),
                                        ),
                                      ],
                                    ),
                            ),
                            Expanded(
                              child: TextField(
                                focusNode: controller.focusInputMessageField,
                                controller: controller.textController,
                                maxLines: 4,
                                minLines: 1,
                                textInputAction: TextInputAction.none,
                                decoration: InputDecoration(
                                  hintStyle: TextDefine.P2_R
                                      .copyWith(color: theme.textDisable),
                                  hintMaxLines: 2,
                                  hintText: 'Input messages',
                                  errorMaxLines: 2,
                                  helperMaxLines: 2,
                                  contentPadding: Spaces.h10v11,
                                  enabledBorder: _borderInputField,
                                  disabledBorder: _borderInputField,
                                  focusedBorder: _borderInputField,
                                  errorBorder: _borderInputField,
                                  focusedErrorBorder: _borderInputField,
                                  filled: true,
                                  fillColor: Colors.white,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: controller.sendMessage,
                              icon: Icon(CupertinoIcons.paperplane,
                                  color: theme.primaryChat),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
