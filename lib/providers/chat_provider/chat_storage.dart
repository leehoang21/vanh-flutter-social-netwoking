import 'package:finplus/providers/chat_provider/models/chat_message_data.dart';
import 'package:finplus/utils/user_storage.dart';

class ChatStorage {
  static List<ChatMessageData> getMessage({required final String? roomId}) {
    return UserStorage.getList(roomId, ChatMessageData.fromJson) ?? [];
  }

  static void saveMessage(
      {required final String roomId,
      required final List<ChatMessageData> value}) {
    UserStorage.putList(roomId, value);
  }
}
