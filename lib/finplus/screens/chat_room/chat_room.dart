import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/chat/chat.dart';
import 'package:finplus/finplus/screens/create_chat_room/create_chat_room.dart';
import 'package:finplus/utils/styles.dart';
import 'package:finplus/utils/svg.dart';
import 'package:finplus/widgets/avatar/avatar.dart';
import 'package:flutter/material.dart';

import 'chat_room_controller.dart';

class ChatRoom extends StatelessWidget {
  const ChatRoom({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.t;
    return GetBuilder<ChatRoomController>(
      builder: (c) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Get.to(
                  () => CreateChatRoom(
                    chatRoomId: c.listChatRoom.value.length + 1,
                  ),
                )?.then((value) => c.getChatRoom());
              },
              icon: SvgPicture.asset(
                SvgIcon.add_icon,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, top: 20),
              height: 40,
              width: 80,
              child: InkWell(
                onTap: c.getChatRoom,
                child: Text(
                  'Refresh',
                  style: TextDefine.T1_M.copyWith(
                      color: theme.primary_02, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () {
                  if (c.listChatRoom.value.isNotEmpty) {
                    return ListView.builder(
                      itemCount: c.listChatRoomDisplay.value.length,
                      itemBuilder: (_, i) {
                        final item = c.listChatRoomDisplay.value[i];
                        return InkWell(
                          onTap: () {
                            Get.to(
                              () => Chat(
                                roomInfo: item,
                              ),
                            );
                          },
                          child: Padding(
                            padding: Spaces.a10,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Avatar(
                                  value: '',
                                  size: 50,
                                ),
                                Spaces.boxW10,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Spaces.box4,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item.name,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextDefine.P1_M,
                                            ),
                                          ),
                                          Spaces.boxW10,
                                        ],
                                      ),
                                      Spaces.boxH5,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item.type.title,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return SizedBox(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              SvgIcon.no_data_icon,
                            ),
                            Spaces.box10,
                            const Text('Không có nhóm chat nào'),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
