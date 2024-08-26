import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commons/commons.dart';
import 'package:finplus/models/chat_room_model.dart';
import 'package:finplus/providers/chat_provider/chat_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../services/auth_service.dart';
import '../home/home_controller.dart';

class ChatRoomController extends GetxController with HomeControllerMinxin {
  late final RefreshController refreshController;

  late final Rx<List<ChatRoomModel>> listChatRoom;

  late final Rx<List<ChatRoomModel>> listChatRoomDisplay;

  final AuthService _auth = AuthService();

  @override
  void onInit() {
    listChatRoom = Rx([]);

    listChatRoomDisplay = Rx([]);

    refreshController = RefreshController();

    getChatRoom();

    super.onInit();
  }

  Future getChatRoom() async {
    listChatRoom.value = [];
    listChatRoomDisplay.value = [];

    await FirebaseFirestore.instance.collection('chatRoom').get().then(
          (snapshot) => snapshot.docs.forEach(
            (element) {
              listChatRoom.update(
                (val) {
                  val!.add(
                    ChatRoomModel(
                      id: element['id'],
                      name: element['name'],
                      type: ROOM_TYPE.values.byName(element['type']),
                      listUid: element['listUid'],
                    ),
                  );
                },
              );
            },
          ),
        );

    listChatRoomDisplay.update(
      (val) {
        val!.addAll(
          listChatRoom.value.where((element) =>
              element.type == ROOM_TYPE.GROUP_PUBLIC ||
              element.listUid.contains(_auth.user!.uid)),
        );
      },
    );
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }
}
