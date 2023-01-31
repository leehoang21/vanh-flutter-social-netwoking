import 'package:cached_network_image/cached_network_image.dart';
import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/chat/chat_controller.dart';
import 'package:finplus/finplus/screens/chat/guest_box/guest_box.dart';
import 'package:finplus/finplus/screens/chat/my_box/my_box.dart';
import 'package:finplus/utils/styles.dart';
import 'package:finplus/widgets/smart_refresh/custom_smart_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  const Chat({
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
                            child: ListView(
                              reverse: true,
                              controller: controller.scrollController,
                              children: [
                                MyBox(
                                  diffTime: null,
                                  onDownloadFile: () {},
                                  onDeleteMessage: () {},
                                ),
                                GuestBox(
                                  diffTime: null,
                                  onDownloadFile: () {},
                                )
                              ],
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
                                          onPressed: (){},
                                          icon: Icon(
                                              CupertinoIcons.photo_camera,
                                              color: theme.primaryChat),
                                        ),
                                        IconButton(
                                          onPressed:(){},
                                          icon: Icon(CupertinoIcons.photo,
                                              color: theme.primaryChat),
                                        ),
                                        IconButton(
                                          onPressed:(){},
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
                              onPressed:(){},
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
