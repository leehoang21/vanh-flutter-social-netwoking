import 'package:commons/commons.dart';
import 'package:finplus/providers/chat_provider/chat_provider.dart';
import 'package:finplus/providers/chat_provider/models/chat_room_info.dart';
import 'package:finplus/utils/get_arguments_mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChatArguments {
  final RxChatRoomInfo roomInfo;

  ChatArguments({required this.roomInfo});
}

class ChatController extends GetxController with GetArguments<ChatArguments> {
  late final ChatProvider _chatProvider;

  late final TextEditingController textController;

  late final FocusNode messageFocusNode;

  late final Rx<bool> isInputExpanded;

  late final ScrollController scrollController;

  late final RefreshController refreshController;

  @override
  void onInit() {
    _chatProvider = ChatProvider();

    textController = TextEditingController();

    messageFocusNode = FocusNode();

    isInputExpanded = Rx(false);

    scrollController = ScrollController();

    refreshController = RefreshController();
    super.onInit();
  }

  @override
  void onReady() {
    if (arguments != null) {
      _chatProvider.getMessage(roomId: arguments!.roomInfo.id);
    }
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

  @override
  void dispose() {
    textController.dispose();
    messageFocusNode.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
