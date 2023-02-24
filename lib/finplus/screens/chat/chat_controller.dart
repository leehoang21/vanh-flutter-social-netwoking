import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/home/home_controller.dart';
import 'package:finplus/models/login_info_data.dart';
import 'package:finplus/providers/chat_provider/chat_provider.dart';
import 'package:finplus/providers/chat_provider/chat_storage.dart';
import 'package:finplus/providers/chat_provider/models/chat_message_data.dart';
import 'package:finplus/providers/chat_provider/models/chat_room_info.dart';
import 'package:finplus/utils/get_arguments_mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChatArguments {
  final RxChatRoomInfo roomInfo;

  ChatArguments({required this.roomInfo});
}

class ChatController extends GetxController
    with GetArguments<ChatArguments>, HomeControllerMinxin {
  late final ChatProvider _chatProvider;

  late final TextEditingController textController;

  late final FocusNode messageFocusNode;

  late final Rx<bool> isInputExpanded;

  late final RefreshController refreshController;

  late final Rx<List<RxChatMessageData>> messages;

  late final Rx<Map<int, UserInfo>> users;

  @override
  void onInit() {
    _chatProvider = ChatProvider();

    textController = TextEditingController();

    messageFocusNode = FocusNode();

    isInputExpanded = Rx(false);

    refreshController = RefreshController();

    messages = Rx<List<RxChatMessageData>>(
        ChatStorage.getMessage(roomId: arguments?.roomInfo.id)
            .map((e) => RxChatMessageData(e))
            .toList());

    users = Rx(_generateUserInfo(
        ChatStorage.getRoomUsers(roomId: arguments?.roomInfo.id)));

    super.onInit();
  }

  @override
  Future<void> onReady() async {
    if (users.value.isNotEmpty) {
      _getRoomUsers();
    } else {
      await _getRoomUsers();
    }

    _getMessage();

    textController.addListener(() {
      if (isInputExpanded.value == false) isInputExpanded.value = true;
    });

    messageFocusNode.addListener(() {
      isInputExpanded(messageFocusNode.hasFocus);
    });

    super.onReady();
  }

  Future<void> _getMessage() async {
    if (arguments != null) {
      final newMsg =
          await _chatProvider.getMessage(roomId: arguments!.roomInfo.id);
      if (newMsg?.isNotEmpty == true) {
        messages.update((val) {
          val?.insertAll(0, newMsg!);
        });
      }
    }
  }

  Future<void> _getRoomUsers() async {
    if (arguments != null) {
      final data =
          await _chatProvider.getUserList(roomId: arguments!.roomInfo.id);

      users.value = _generateUserInfo(data);
    }
  }

  Map<int, UserInfo> _generateUserInfo(List<UserInfo> value) {
    final Map<int, UserInfo> result = {};

    value.forEach((element) {
      result[element.id] = element;
    });

    return result;
  }

  RxChatRoomInfo? get roomInfo => arguments?.roomInfo;

  @override
  void dispose() {
    textController.dispose();
    messageFocusNode.dispose();
    super.dispose();
  }
}
