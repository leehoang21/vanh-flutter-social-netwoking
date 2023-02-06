import 'dart:io';

import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/create_chat_room/select_room_type/select_room_type_mbs.dart';
import 'package:finplus/providers/chat_provider/chat_provider.dart';
import 'package:flutter/cupertino.dart';

class CreateChatRoomController extends GetxController {
  late final ChatProvider _chatProvider;

  late final TextEditingController nameRoomController;

  late final Rx<ROOM_TYPE> roomType;

  late final Rx<File?> imagePath;

  late final Rx<bool> enableCreate;

  @override
  void onInit() {
    _chatProvider = ChatProvider();
    nameRoomController = TextEditingController();
    roomType = Rx(ROOM_TYPE.GROUP_PUBLIC);
    imagePath = Rx(null);
    enableCreate = Rx(false);
    super.onInit();
  }

  Future<void> createRoomChat() async {
    final res = await _chatProvider.createRoom(
        name: nameRoomController.text, type: roomType.value);
    if (res != null) {
      Get.back(result: true);
    }
  }

  void changeRoomTypeHandler() {
    Get.bottomSheet(
      SelectRoomTypeMbs(valueSelected: roomType),
      ignoreSafeArea: false,
      isScrollControlled: true,
    );
  }

  void enableCreateRoomHandler(String value) {
    if (value.isNotEmpty) {
      enableCreate(true);
    }
  }

  @override
  void onClose() {
    nameRoomController.dispose();
    super.onClose();
  }
}
