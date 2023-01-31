
import 'package:commons/commons.dart';
import 'package:finplus/core/get_arguments.dart';
import 'package:finplus/models/login_info_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChatArgument {
  final UserInfo userChatWith;

  ChatArgument({
    required this.userChatWith,
  });
}

class ChatController extends GetxController with GetArguments<ChatArgument> {
  final String userId = '0';

  final TextEditingController textController = TextEditingController();

  final FocusNode focusInputMessageField = FocusNode();

  final Rx<bool> onExpandedInputField = Rx(false);

  final ScrollController scrollController = ScrollController();

  final RefreshController refreshController = RefreshController();

  late Rxn<UserInfo> userChatWith;

  @override
  void onInit() {
    textController.addListener(
      () {
        if (onExpandedInputField.value == false)
          onExpandedInputField.value = true;
      },
    );

    focusInputMessageField.addListener(
      () {
        if (focusInputMessageField.hasFocus &&
            onExpandedInputField.value == false)
          onExpandedInputField.value = true;

        if (!focusInputMessageField.hasFocus &&
            onExpandedInputField.value == true)
          onExpandedInputField.value = false;
      },
    );

    userChatWith = Rxn(arguments?.userChatWith);

    super.onInit();
  }

  @override
  void dispose() {
    textController.dispose();
    focusInputMessageField.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
