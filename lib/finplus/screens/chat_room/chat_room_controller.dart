import 'package:commons/commons.dart';
import 'package:finplus/providers/chat_provider/chat_provider.dart';
import 'package:finplus/providers/chat_provider/models/chat_room_info.dart';
import 'package:finplus/utils/types.dart';
import 'package:finplus/utils/user_storage.dart';

import '../../../routes/finplus_routes.dart';
import '../chat/chat_controller.dart';
import '../home/home_controller.dart';

class ChatRoomController extends GetxController with HomeControllerMinxin {
  late final ChatProvider _chatProvider;

  late final Rx<List<RxChatRoomInfo>> chatRoom;

  @override
  void onInit() {
    _chatProvider = ChatProvider();

    chatRoom = Rx(UserStorage.getList(KEY.CHAT_ROOM, ChatRoomInfo.fromJson)
            ?.map((e) => RxChatRoomInfo(e))
            .toList() ??
        []);

    super.onInit();
  }

  @override
  void onReady() {
    _getRoom();
    super.onReady();
  }

  Future<void> _getRoom() async {
    chatRoom.value = await _chatProvider.getRoom();
  }

  Future<void> navigateToRoom(RxChatRoomInfo roomInfo) async {
    if (!roomInfo.userIds.contains(userInfo?.userInfo.id)) {
      final result = await LoadingOverlay.load(
          _chatProvider.joinRoom(roomId: roomInfo.id));
      if (result) {
        roomInfo.update((val) {
          val!.userIds.add(userInfo!.userInfo.id);
        });
      }
    }
    Get.toNamed(Routes.chat, arguments: ChatArguments(roomInfo: roomInfo));
  }
}
