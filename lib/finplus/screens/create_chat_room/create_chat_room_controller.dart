import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/create_chat_room/select_room_type/select_room_type_mbs.dart';
import 'package:finplus/models/chat_room_model.dart';
import 'package:finplus/providers/chat_provider/chat_provider.dart';
import 'package:finplus/services/database.dart';
import 'package:flutter/cupertino.dart';

import '../../../services/auth_service.dart';

class CreateChatRoomController extends GetxController {
  late final TextEditingController nameRoomController;

  late final Rx<ROOM_TYPE> roomType;

  late final RxnString imagePath;

  late final Rx<bool> enableCreate;

  late final int id;

  final AuthService _auth = AuthService();

  late List<String> listUid;

  CreateChatRoomController({required this.id});

  @override
  void onInit() {
    nameRoomController = TextEditingController();
    roomType = Rx(ROOM_TYPE.GROUP_PUBLIC);
    imagePath = RxnString();
    enableCreate = Rx(false);
    listUid = [];
    super.onInit();
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

  Future<void> createChatRoom() async {
    listUid.add(_auth.user!.uid);
    await DatabaseService(uid: _auth.user!.uid).createChatRoom(
      ChatRoomModel(
        id: id,
        name: nameRoomController.value.text,
        type: roomType.value,
        listUid: listUid,
      ),
    );
    Get.back();
  }

  @override
  void onClose() {
    nameRoomController.dispose();
    super.onClose();
  }
}
