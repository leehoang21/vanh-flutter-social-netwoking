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

  late final RxString textSearch;

  late final Rx<bool> isShowSearch;

  @override
  void onInit() {
    _chatProvider = ChatProvider();
    chatRoom = Rx(UserStorage.getList(KEY.CHAT_ROOM, ChatRoomInfo.fromJson)
            ?.map((e) => RxChatRoomInfo(e))
            .toList() ??
        []);

    refreshController = RefreshController();
    textSearch = RxString('');
    isShowSearch = Rx(false);
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

  void onSubmitSearch(String value) {
    textSearch(value);
  }

  ///Show/Hide field search
  void btnSearchHandler() {
    isShowSearch(!isShowSearch.value);
    if (!isShowSearch.value) textSearch('');
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }
}
