import 'package:commons/commons.dart';
import 'package:finplus/base/app_config/app_config.dart';
import 'package:finplus/utils/types.dart';
import 'package:finplus/utils/user_storage.dart';

import '../../base/base.dart';
import '../api_path.dart';
import 'models/chat_room_info.dart';

// ignore: camel_case_types
enum ROOM_TYPE {
  GROUP_PRIVATE,
  GROUP_PUBLIC,
  DIRECT;

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

  Future<void> createRoom(
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

    final res = await sendRequest(req);

    if (res.success) {
    } else {}
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

  Future<void> getMessage({required final String roomId}) async {
    final params = {
      'roomId': roomId,
      'fetchCount': AppConfig.info.fetchCount.toString(),
    };
    final ApiRequest req = ApiRequest(
      path: ApiPath.message,
      method: METHOD.GET,
      auth: true,
      query: params,
    );

    final res = await sendRequest(req);

    if (res.success) {
    } else {}
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
}
