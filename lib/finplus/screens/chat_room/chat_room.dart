import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chat_room_controller.dart';

class ChatRoom extends StatelessWidget {
  const ChatRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatRoomController>(
      builder: (c) => Scaffold(
        appBar: AppBar(),
        body: Obx(
          () => ListView.builder(
            itemCount: c.chatRoom.value.length,
            itemBuilder: (_, i) {
              final item = c.chatRoom.value[i];
              return InkWell(
                onTap: () => c.navigateToRoom(item),
                child: Row(
                  children: [Text(item.name)],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
