import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/chat/chat_controller.dart';
import 'package:finplus/models/chat_room_model.dart';
import 'package:finplus/utils/styles.dart';
import 'package:finplus/widgets/avatar/avatar.dart';
import 'package:finplus/widgets/smart_refresh/custom_smart_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  const Chat({super.key, required this.roomInfo});

  final ChatRoomModel roomInfo;

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
        init: ChatController(roomInfo: roomInfo),
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
                      children: [
                        Text(
                          roomInfo.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextDefine.T1_R,
                        ),
                        Text(
                          '${roomInfo.listUid.length} thành viên',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 20),
                    height: 40,
                    width: 80,
                    child: InkWell(
                      onTap: c.getMessage,
                      child: Text(
                        'Refresh',
                        style: TextDefine.T1_M.copyWith(
                            color: theme.primary_02,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomSmartRefresher(
                      controller: c.refreshController,
                      child: Obx(
                        () => ListView.builder(
                          padding: Spaces.a16,
                          itemCount: c.listMessage.value.length,
                          reverse: true,
                          itemBuilder: (ctx, i) {
                            final int num = c.listMessage.value.length - 1 - i;
                            final msg = c.listMessage.value[num];

                            return Column(
                              children: [
                                Row(
                                  children: [
                                    const Expanded(child: Divider(height: 1)),
                                    Padding(
                                      padding: Spaces.h8v16,
                                      child: Text(
                                        msg.time,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Avatar(
                                        value: '',
                                        size: 32,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              msg.name,
                                              textAlign: TextAlign.right,
                                              style: TextDefine.P3_R.copyWith(
                                                  color: theme.textDisable),
                                            ),
                                            Text(
                                              msg.content,
                                              textAlign: TextAlign.right,
                                              style: TextDefine.P3_R.copyWith(),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
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
                          onPressed: () {
                            if (c.textController.value.text != '') {
                              c.sendMessage();
                              c.textController.clear();
                              FocusScope.of(context).unfocus();
                            }
                          },
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
}
