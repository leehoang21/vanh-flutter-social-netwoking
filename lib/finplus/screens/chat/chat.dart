import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/chat/chat_controller.dart';
import 'package:finplus/finplus/screens/chat/guest_box/guest_box.dart';
import 'package:finplus/finplus/screens/chat/my_box/my_box.dart';
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

    final InputBorder _borderInputField = OutlineInputBorder(
      borderSide: BorderSide(
        color: theme.primaryChat,
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
                  const Avatar(
                    value: '',
                    size: 40,
                  ),
                  Spaces.box10,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Tên người đang chat',
                          overflow: TextOverflow.ellipsis,
                          style: TextDefine.T1_R,
                        ),
                        Text(
                          'Trực tuyến',
                          style: TextDefine.P3_R,
                        ),
                      ],
                    ),
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
                                  msg.createdBy;
                            }

                            if (msg.createdBy == c.userInfo?.userInfo.id) {
                              return MyBox(
                                onDownloadFile: () {},
                                data: msg,
                                isSameUser: isSameUser,
                              );
                            }

                            return GuestBox(
                              onDownloadFile: () {},
                              data: msg,
                              isSameUser: isSameUser,
                            );
                          },
                        ),
                      );
                    }),
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
                          () => c.isInputExpanded.value
                              ? IconButton(
                                  onPressed: () =>
                                      c.isInputExpanded.value = false,
                                  icon: Icon(
                                    CupertinoIcons.chevron_right,
                                    color: theme.primaryChat,
                                  ),
                                )
                              : Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(CupertinoIcons.photo_camera,
                                          color: theme.primaryChat),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(CupertinoIcons.photo,
                                          color: theme.primaryChat),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(CupertinoIcons.arrow_up_doc,
                                          color: theme.primaryChat),
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
                          icon: Icon(CupertinoIcons.paperplane,
                              color: theme.primaryChat),
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
}
