import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/chat/chat_controller.dart';
import 'package:finplus/finplus/screens/chat/guest_box/guest_box.dart';
import 'package:finplus/finplus/screens/chat/my_box/my_box.dart';
import 'package:finplus/models/common_styles.dart';
import 'package:finplus/models/login_info_data.dart';
import 'package:finplus/providers/chat_provider/models/chat_message_data.dart';
import 'package:finplus/utils/styles.dart';
import 'package:finplus/widgets/avatar/avatar.dart';
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

    const InputBorder _borderInputField = OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
      ),
      borderRadius: Decorate.r15,
    );

    return GetBuilder<ChatController>(
        init: ChatController(),
        builder: (c) {
          return Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(() => Avatar(
                        value: c.roomInfo?.value.avatar ?? '',
                        size: 40,
                      )),
                  Spaces.box10,
                  Expanded(
                    child: Obx(() => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              c.roomInfo?.name ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: TextDefine.T1_R,
                            ),
                            Text(
                              '${c.roomInfo?.userIds.length ?? 0} thành viên',
                              style: TextDefine.P3_R,
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                children: [
                  Expanded(
                    child: Obx(() {
                      return CustomSmartRefresher(
                        controller: c.refreshController,
                        child: ListView.builder(
                          padding: Spaces.a16,
                          itemCount: c.messages.value.length,
                          reverse: true,
                          itemBuilder: (ctx, i) {
                            final msg = c.messages.value[i];
                            bool isSameUser = false;
                            if (i + 1 < c.messages.value.length) {
                              isSameUser = c.messages.value[i + 1].createdBy ==
                                      msg.createdBy &&
                                  c.messages.value[i + 1].type !=
                                      MESSAGE_TYPE.USER_JOINED;
                            }

                            final userInfo = c.users.value[msg.sender];

                            final notifyWidget =
                                _generateNotify(msg, theme, userInfo);

                            if (notifyWidget != null) return notifyWidget;

                            if (msg.createdBy == c.userInfo?.userInfo.id) {
                              return MyBox(
                                onDownloadFile: () {},
                                data: msg,
                                isSameUser: isSameUser,
                                userInfo: userInfo,
                              );
                            }

                            return GuestBox(
                              onDownloadFile: () {},
                              data: msg,
                              isSameUser: isSameUser,
                              userInfo: userInfo,
                            );
                          },
                        ),
                      );
                    }),
                  ),
                  Container(
                    padding: Spaces.v10,
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Obx(
                          () => c.isInputExpanded.value
                              ? IconButton(
                                  onPressed: () =>
                                      c.isInputExpanded.value = false,
                                  icon: const Icon(
                                    CupertinoIcons.chevron_right,
                                  ),
                                )
                              : Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                          CupertinoIcons.photo_camera),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(CupertinoIcons.photo),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                          CupertinoIcons.arrow_up_doc),
                                    ),
                                  ],
                                ),
                        ),
                        Expanded(
                          child: TextField(
                            focusNode: c.messageFocusNode,
                            controller: c.textController,
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
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.paperplane),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget? _generateNotify(
      RxChatMessageData data, CommonStyles theme, UserInfo? userInfo) {
    final ChatController c = Get.find();

    switch (data.type) {
      case MESSAGE_TYPE.USER_JOINED:
        return Container(
          padding: Spaces.v8,
          alignment: Alignment.center,
          child: Text(
            '${data.createdBy == c.userInfo?.userInfo.id ? 'Bạn' : userInfo?.displayName ?? 'User'} đã tham gia cuộc hội thoại',
            style: TextStyle(color: theme.textDisable),
          ),
        );
      case MESSAGE_TYPE.ROOM_ADDED:
        return Container(
          padding: Spaces.v8,
          alignment: Alignment.center,
          child: Text(
            '${data.createdBy == c.userInfo?.userInfo.id ? 'Bạn' : userInfo?.displayName ?? 'User'} đã tạo cuộc hội thoại',
            style: TextStyle(color: theme.textDisable),
          ),
        );
      case MESSAGE_TYPE.ROOM_REMOVED:
        return Container(
          padding: Spaces.v8,
          alignment: Alignment.center,
          child: Text(
            '${data.createdBy == c.userInfo?.userInfo.id ? 'Bạn' : userInfo?.displayName ?? 'User'} đã xóa cuộc hội thoại',
            style: TextStyle(color: theme.textDisable),
          ),
        );

      default:
        return null;
    }
  }
}
