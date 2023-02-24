import 'package:commons/commons.dart';
import 'package:finplus/base/app_config/app_config.dart';
import 'package:finplus/models/login_info_data.dart';
import 'package:finplus/providers/chat_provider/chat_storage.dart';
import 'package:finplus/providers/chat_provider/models/chat_message_data.dart';
import 'package:finplus/utils/svg.dart';
import 'package:finplus/utils/types.dart';
import 'package:finplus/utils/user_storage.dart';

import '../../base/base.dart';
import '../api_path.dart';
import 'models/chat_room_info.dart';

// ignore: camel_case_types
enum ROOM_TYPE {
  DIRECT(
      icon: SvgIcon.private_icon,
      title: 'Chat với bạn bè',
      desc: 'Người dùng có thể thay đổi thông tin'),
  GROUP_PRIVATE(
      icon: SvgIcon.private_icon,
      title: 'Nhóm riêng tư',
      desc: 'Chỉ admin mới có thể thay đổi thông tin nhóm'),
  GROUP_PUBLIC(
      icon: SvgIcon.public_icon,
      title: 'Nhóm công khai',
      desc: 'Thành viên trong nhóm có thể thay đổi thông tin nhóm');

  final String icon;
  final String title;
  final String desc;

  const ROOM_TYPE(
      {required this.title, required this.desc, required this.icon});
  factory ROOM_TYPE.from(String? value) =>
      values.firstWhereOrNull((element) => element.name == value) ??
      ROOM_TYPE.GROUP_PRIVATE;
}

class ChatProvider extends BaseNetWork {
  Future<List<RxChatRoomInfo>> getRoom() async {
    final ApiRequest req = ApiRequest(
      path: ApiPath.room,
      method: METHOD.GET,
      auth: true,
    );

    final res = await sendRequest(req, decoder: ChatRoomInfo.fromJson);

    if (res.success) {
      UserStorage.putList(KEY.CHAT_ROOM, res.items);
      return res.items.map((e) => RxChatRoomInfo(e)).toList();
    } else {
      return [];
    }
  }

  Future<RxChatRoomInfo?> createRoom(
      {required final String name, required final ROOM_TYPE type}) async {
    final params = {
      'name': name,
      'type': type.name,
    };

    final ApiRequest req = ApiRequest(
      path: ApiPath.room,
      method: METHOD.POST,
      auth: true,
      body: params,
    );

    final res = await sendRequest(req, decoder: ChatRoomInfo.fromJson);

    if (res.success) {
      final infoRoom = res.body;
      final chatRoom = UserStorage.getList(KEY.CHAT_ROOM, ChatRoomInfo.fromJson)
              ?.map((e) => e)
              .toList() ??
          [];
      chatRoom.add(infoRoom);
      UserStorage.putList(KEY.CHAT_ROOM, chatRoom);
      return RxChatRoomInfo(infoRoom);
    } else {
      return null;
    }
  }

  Future<bool> updateRoom(
      {required final String name, required final String id}) async {
    final params = {
      'name': name,
      '_id': id,
    };

    final ApiRequest req = ApiRequest(
      path: ApiPath.room,
      method: METHOD.PUT,
      auth: true,
      body: params,
    );

    final res = await sendRequest(req);

    return res.success;
  }

  Future<bool> deleteRoom({required final String id}) async {
    final params = {'_id': id};

    final ApiRequest req = ApiRequest(
      path: ApiPath.room,
      method: METHOD.DELETE,
      auth: true,
      query: params,
    );

    final res = await sendRequest(req);

    return res.success;
  }

  Future<bool> joinRoom({required final String roomId}) async {
    final params = {'roomId': roomId};

    final ApiRequest req = ApiRequest(
      path: ApiPath.joinRoom,
      method: METHOD.POST,
      auth: true,
      body: params,
    );

    final res = await sendRequest(req);

    return res.success;
  }

  Future<bool> leftRoom({required final String roomId}) async {
    final params = {'roomId': roomId};

    final ApiRequest req = ApiRequest(
      path: ApiPath.leftRoom,
      method: METHOD.POST,
      auth: true,
      body: params,
    );

    final res = await sendRequest(req);

    return res.success;
  }

  Future<void> addUserToRoom(
      {required final String roomId, required final int userId}) async {
    final params = {'roomId': roomId, 'addUserId': userId};

    final ApiRequest req = ApiRequest(
      path: ApiPath.addUserToRoom,
      method: METHOD.POST,
      auth: true,
      body: params,
    );

    final res = await sendRequest(req);

    if (res.success) {
    } else {}
  }

  Future<void> removeUserToRoom(
      {required final String roomId, required final int userId}) async {
    final params = {'roomId': roomId, 'addUserId': userId};

    final ApiRequest req = ApiRequest(
      path: ApiPath.removeUserToRoom,
      method: METHOD.POST,
      auth: true,
      body: params,
    );

    final res = await sendRequest(req);

    if (res.success) {
    } else {}
  }

  Future<List<RxChatMessageData>?> getMessage(
      {required final String roomId,
      final int? lastTime,
      final int? from}) async {
    final params = {
      'roomId': roomId,
      if (from == null) 'fetchCount': AppConfig.info.fetchCount.toString(),
      if (from == null) 'lastTime': lastTime?.toString(),
      'from': from?.toString(),
      if (from != null) 'to': lastTime?.toString(),
    }.json;

    final ApiRequest req = ApiRequest(
      path: ApiPath.message,
      method: METHOD.GET,
      auth: true,
      query: params,
    );

    final res = await sendRequest(req, decoder: ChatMessageData.fromJson);

    if (res.success) {
      final List<RxChatMessageData> newMsg = [];
      final msgList = ChatStorage.getMessage(roomId: roomId);

      res.items.forEach((element) {
        final mes = msgList.firstWhereOrNull((e) => e.id == element.id);

        if (mes != null) {
          mes.copy(element);
        } else {
          msgList.add(element);
          newMsg.add(RxChatMessageData(element));
        }
      });

      msgList.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      ChatStorage.saveMessage(roomId: roomId, value: msgList);

      return newMsg;
    } else {
      return null;
    }
  }

  Future<void> sendMessage(
      {required final String roomId, required final String content}) async {
    final params = {
      'roomId': roomId,
      'content': content,
    };
    final ApiRequest req = ApiRequest(
      path: ApiPath.message,
      method: METHOD.POST,
      auth: true,
      body: params,
    );

    final res = await sendRequest(req);

    if (res.success) {
    } else {}
  }

  Future<List<UserInfo>> getUserList({required final String roomId}) async {
    final params = {'roomId': roomId};
    final ApiRequest req = ApiRequest(
      path: ApiPath.userList,
      method: METHOD.GET,
      auth: true,
      query: params,
    );

    final res = await sendRequest(req, decoder: UserInfo.fromJson);

    if (res.success) {
      ChatStorage.saveRoomUsers(roomId: roomId, value: res.items);

      return res.items;
    } else {
      return [];
    }
  }
}
