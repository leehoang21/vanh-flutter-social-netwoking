import 'package:finplus/providers/chat_provider/chat_provider.dart';
import 'package:finplus/providers/chat_provider/models/chat_room_info.dart';
import 'package:finplus/utils/types.dart';
import 'package:finplus/utils/user_storage.dart';
import 'package:get/get.dart';

class ChatRoomController extends GetxController {
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
}
