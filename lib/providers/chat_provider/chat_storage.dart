import 'package:finplus/models/login_info_data.dart';
import 'package:finplus/providers/chat_provider/models/chat_message_data.dart';
import 'package:finplus/utils/user_storage.dart';

class ChatStorage {
  static List<ChatMessageData> getMessage({required final String? roomId}) {
    return UserStorage.getList('${roomId}_msg', ChatMessageData.fromJson) ?? [];
  }

  static void saveMessage(
      {required final String roomId,
      required final List<ChatMessageData> value}) {
    UserStorage.putList('${roomId}_msg', value);
  }

  static List<UserInfo> getRoomUsers({required final String? roomId}) {
    return UserStorage.getList('${roomId}_users', UserInfo.fromJson) ?? [];
  }

  static void saveRoomUsers(
      {required final String? roomId, required final List<UserInfo> value}) {
    UserStorage.putList('${roomId}_users', value);
  }
}
