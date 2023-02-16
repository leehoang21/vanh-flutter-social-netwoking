import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/home/home_controller.dart';
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
    super.onInit();
  }

  @override
  void onReady() {
    _getMessage();
    textController.addListener(
      () {
        if (isInputExpanded.value == false) isInputExpanded.value = true;
      },
    );

    messageFocusNode.addListener(
      () {
        isInputExpanded(messageFocusNode.hasFocus);
      },
    );
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

  @override
  void dispose() {
    textController.dispose();
    messageFocusNode.dispose();
    super.dispose();
  }
}
