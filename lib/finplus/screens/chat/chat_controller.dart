import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commons/commons.dart';
import 'package:finplus/models/message_chat_model.dart';
import 'package:finplus/providers/chat_provider/models/chat_message_data.dart';
import 'package:finplus/providers/chat_provider/models/chat_room_info.dart';
import 'package:finplus/services/auth_service.dart';
import 'package:finplus/services/database.dart';
import 'package:finplus/utils/get_arguments_mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../models/chat_room_model.dart';

class ChatArguments {
  final RxChatRoomInfo roomInfo;

  ChatArguments({required this.roomInfo});
}

class ChatController extends GetxController with GetArguments<ChatArguments> {
  late final TextEditingController textController;

  late final FocusNode messageFocusNode;

  late final Rx<bool> isInputExpanded;

  late final RefreshController refreshController;

  late final Rx<List<RxChatMessageData>> messages;

  late final ChatRoomModel roomInfo;

  late final Rx<List<MessageChatModel>> listMessage;

  late final RxString name;

  final AuthService _auth = AuthService();

  ChatController({required this.roomInfo});

  @override
  void onInit() {
    listMessage = Rx([]);

    textController = TextEditingController();

    messageFocusNode = FocusNode();

    isInputExpanded = Rx(false);

    refreshController = RefreshController();

    name = RxString('');

    getName();

    getMessage();

    super.onInit();
  }

  Future getName() async {
    await FirebaseFirestore.instance.collection('user').get().then(
          (snapshot) => snapshot.docs.forEach(
            (element) {
              if (element['uid'] == _auth.user!.uid) {
                if (element['name'].toString() != '') {
                  name.value = element['name'];
                }
              }
            },
          ),
        );
  }

  Future getMessage() async {
    listMessage.value = [];

    await FirebaseFirestore.instance
        .collection('chatMessage')
        .orderBy('idMessage', descending: false)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (element) {
              if (element['id'] == roomInfo.id) {
                final List<dynamic> list = element['listMessage'];
                list.forEach(
                  (element) {
                    listMessage.update(
                      (val) {
                        val!.add(
                          MessageChatModel(
                            name: element['name'],
                            content: element['content'],
                            time: element['time'],
                          ),
                        );
                      },
                    );
                  },
                );
              }
            },
          ),
        );
  }

  Future<void> sendMessage() async {
    listMessage.value.add(
      MessageChatModel(
        name: name.value,
        content: textController.value.text,
        time: DateTime.now().toString(),
      ),
    );
    print(name.value);
    await DatabaseService(uid: _auth.user!.uid).sendMessage(
      roomInfo.id,
      MessageChatModel(
        name: name.value,
        content: textController.value.text,
        time: DateTime.now().toString(),
      ),
      listMessage.value.length + 1,
    );
    getMessage();
  }

  @override
  void dispose() {
    textController.dispose();
    messageFocusNode.dispose();
    super.dispose();
  }
}
