import 'package:commons/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChatController extends GetxController {
  late final TextEditingController textController;

  late final FocusNode messageFocusNode;

  late final Rx<bool> isExpandedInputField;

  late final ScrollController scrollController;

  late final RefreshController refreshController;

  @override
  void onInit() {
    textController = TextEditingController();
    messageFocusNode = FocusNode();
    isExpandedInputField = Rx(false);
    scrollController = ScrollController();
    refreshController = RefreshController();

    super.onInit();
  }

  @override
  void onReady() {
    textController.addListener(
      () {
        if (isExpandedInputField.value == false)
          isExpandedInputField.value = true;
      },
    );

    messageFocusNode.addListener(
      () {
        isExpandedInputField(messageFocusNode.hasFocus);
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
