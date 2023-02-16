import 'package:commons/commons.dart';
import 'package:finplus/providers/chat_provider/models/chat_message_data.dart';

import '../chat_provider.dart';

class RxChatRoomInfo extends Rx<ChatRoomInfo> {
  RxChatRoomInfo(super.initial);

  String get id => value.id;
  ROOM_TYPE get type => value.type;
  String get name => value.name;
  int get lastMsgTime => value.lastMsgTime;
  int get msgCount => value.msgCount;
  bool get isLeaveAble => value.isLeaveAble;
  bool get isReadOnly => value.isReadOnly;
  List<int> get userIds => value.userIds;
  List<int> get adminIds => value.adminIds;
  int get createdBy => value.createdBy;
  int? get updatedBy => value.updatedBy;
  int? get updatedAt => value.updatedAt;
  int get createdAt => value.createdAt;
  ChatMessageData? get lastMsg => value.lastMsg;
}

class ChatRoomInfo extends ExtendModel {
  late final String id;

  late final ROOM_TYPE type;

  late final String name;

  late final int lastMsgTime;

  late int msgCount;

  late bool isLeaveAble;

  late bool isReadOnly;

  late final List<int> userIds;

  late final List<int> adminIds;

  late final int createdBy;

  ChatMessageData? lastMsg;

  int? updatedBy;

  int? updatedAt;

  late final int createdAt;

  ChatRoomInfo(
      {required this.id,
      required this.type,
      required this.name,
      required this.lastMsgTime,
      required this.msgCount,
      this.isLeaveAble = true,
      this.isReadOnly = false,
      required this.userIds,
      required this.adminIds,
      required this.createdBy,
      this.updatedBy,
      this.updatedAt,
      required this.createdAt});

  ChatRoomInfo.fromJson(Map<dynamic, dynamic> json) {
    id = json['_id'] ?? '';
    type = ROOM_TYPE.from(json['type']);
    name = json['name'] ?? '';
    lastMsgTime = json['lastMsgTime'] ?? DateTime.now().millisecondsSinceEpoch;
    msgCount = json['msgCount'] ?? 0;
    isLeaveAble = json['isLeaveAble'] ?? true;
    isReadOnly = json['isReadOnly'] ?? false;
    userIds = json['userIds']?.cast<int>() ?? [];
    adminIds = json['adminIds']?.cast<int>() ?? [];
    createdBy = json['createdBy'] ?? -1;
    updatedBy = json['updatedBy'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'] ?? DateTime.now().millisecondsSinceEpoch;
    if (json['lastMsg'] != null) {
      lastMsg = ChatMessageData.fromJson(json['lastMsg']);
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['type'] = type.name;
    data['name'] = name;
    data['lastMsgTime'] = lastMsgTime;
    data['msgCount'] = msgCount;
    data['isLeaveAble'] = isLeaveAble;
    data['isReadOnly'] = isReadOnly;
    data['userIds'] = userIds;
    data['adminIds'] = adminIds;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    data['lastMsg'] = lastMsg?.toJson();
    return data;
  }
}
