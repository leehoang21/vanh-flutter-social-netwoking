import 'package:commons/commons.dart';

// ignore: camel_case_types
enum MESSAGE_TYPE {
  CHAT,
  ROOM_CHANGED,
  ROOM_REMOVED,
  ROOM_ADDED,
  USER_ADD_BY,
  USER_REMOVED_BY,
  USER_LEFT,
  USER_JOINED,
  MESSAGE_REACTED,
  MESSAGE_REMOVED;

  factory MESSAGE_TYPE.from(String? value) =>
      values.firstWhereOrNull((element) => element.name == value) ??
      MESSAGE_TYPE.CHAT;
}

class RxChatMessageData extends Rx<ChatMessageData> {
  RxChatMessageData(super.initial);

  String get id => value.id;
  MESSAGE_TYPE get type => value.type;
  String get roomId => value.roomId;
  String get content => value.content;
  int get sender => value.sender; // user id người gửi
  ChatMessageData? get replyFor => value.replyFor;
  List<Reaction> get reactions => value.reactions;
  int get createdBy => value.createdBy;
  int get createdAt => value.createdAt;
  int? get updatedBy => value.updatedBy;
  int? get updatedAt => value.updatedAt;
  int? get expireAt => value.expireAt;
  List<int> get mentionIds => value.mentionIds;
}

class ChatMessageData {
  late final String id;
  late final MESSAGE_TYPE type;
  late final String roomId;
  late String content;
  late final int sender; // user id người gửi
  ChatMessageData? replyFor;
  late final List<Reaction> reactions;
  late final int createdBy;
  late final int createdAt;
  int? updatedBy;
  int? updatedAt;
  int? expireAt;
  late final List<int> mentionIds;

  ChatMessageData({
    required this.id,
    this.type = MESSAGE_TYPE.CHAT,
    required this.roomId,
    this.content = '',
    required this.sender,
    this.replyFor,
    required this.reactions,
    required this.createdBy,
    this.expireAt,
    required this.mentionIds,
  }) {
    createdAt = DateTime.now().microsecondsSinceEpoch;
  }

  ChatMessageData.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? -1;
    type = MESSAGE_TYPE.from(json['type']);
    roomId = json['roomId'] ?? '';
    content = json['content'];
    sender = json['sender'] ?? -1;
    replyFor = json['replyFor'] != null
        ? ChatMessageData.fromJson(json['replyFor'])
        : null;
    reactions = json['reactions'] is List
        ? (json['reactions'] as List).map((e) => Reaction.fromJson(e)).toList()
        : [];
    createdBy = json['createdBy'] ?? -1;
    createdAt = json['createdAt'] ?? DateTime.now().millisecondsSinceEpoch;
    mentionIds = json['mentionIds']?.cast<int>() ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['type'] = type.name;
    data['roomId'] = roomId;
    data['content'] = content;
    data['sender'] = sender;
    data['replyFor'] = replyFor?.toJson();
    data['reactions'] = reactions.map((v) => v.toJson()).toList();
    data['createdBy'] = createdBy;
    data['createdAt'] = createdAt;
    return data;
  }
}

// ignore: camel_case_types
enum REACTION_TYPE {
  LIKE,
  DISLIKE;
}

class Reaction {
  late final int userId;
  String? action;

  Reaction({required this.userId, this.action});

  Reaction.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] ?? -1;
    action = json['action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['action'] = action;
    return data;
  }
}
