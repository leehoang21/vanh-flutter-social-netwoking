import 'package:commons/commons.dart';
import 'package:finplus/providers/chat_provider/chat_provider.dart';
import 'package:finplus/providers/chat_provider/models/chat_room_info.dart';
import 'package:finplus/routes/finplus_routes.dart';
import 'package:finplus/utils/types.dart';
import 'package:finplus/utils/user_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../chat/chat_controller.dart';
import '../home/home_controller.dart';

class ChatRoomController extends GetxController with HomeControllerMinxin {
  late final ChatProvider _chatProvider;

  late final Rx<List<RxChatRoomInfo>> rooms;

  late final RefreshController refreshController;

  late final RxString textSearch;

  late final Rx<bool> isShowSearch;

  @override
  void onInit() {
    _chatProvider = ChatProvider();
    rooms = Rx(UserStorage.getList(KEY.CHAT_ROOM, ChatRoomInfo.fromJson)
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
    final rooms = await _chatProvider.getRoom();
    if (rooms.isNotEmpty) {
      this.rooms(rooms);
    }
  }

  Future<void> onRefresh() async {
    await _getRoom();
    refreshController.refreshCompleted();
  }

  void onSubmitSearch(String value) {
    textSearch(value);
  }

  ///Show/Hide field search
  void onIconSearchPress() {
    isShowSearch.toggle();
    if (!isShowSearch.value) textSearch('');
  }

  Future<void> createChatRoomHandler() async {
    final value = await Get.toNamed(
      Routes.create_chat_room,
    );

    if (value == true)
      rooms(UserStorage.getList(KEY.CHAT_ROOM, ChatRoomInfo.fromJson)
              ?.map((e) => RxChatRoomInfo(e))
              .toList() ??
          []);
  }

  List<RxChatRoomInfo> get searchRooms => rooms.value
      .where((room) => room.name.contains(textSearch.value))
      .toList();

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

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }
}
