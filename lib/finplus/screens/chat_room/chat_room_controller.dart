import 'package:commons/app_logger/app_devtools/app_devtools.dart';
import 'package:commons/app_logger/app_logger.dart';
import 'package:finplus/providers/chat_provider/chat_provider.dart';
import 'package:finplus/providers/chat_provider/models/chat_room_info.dart';
import 'package:finplus/utils/types.dart';
import 'package:finplus/utils/user_storage.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChatRoomController extends GetxController {
  late final ChatProvider _chatProvider;

  late final Rx<List<RxChatRoomInfo>> chatRoom;

  late final RefreshController refreshController;
  @override
  void onInit() {
    _chatProvider = ChatProvider();

    chatRoom = Rx(UserStorage.getList(KEY.CHAT_ROOM, ChatRoomInfo.fromJson)
            ?.map((e) => RxChatRoomInfo(e))
            .toList() ??
        []);

    refreshController = RefreshController();
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

  Future<void> reload() async {
    await _getRoom();
    refreshController.refreshCompleted();
  }
}
