import 'package:commons/commons.dart';

import '../../../models/login_info_data.dart';

enum FeedType {
  NONE,
  POST;

  factory FeedType.from(String? value) =>
      values.firstWhereOrNull((element) => element.name == value) ??
      FeedType.NONE;
}

class RxFeedData extends Rx<FeedData> {
  RxFeedData(super.initial);

  int get id => value.id;
  String get attachment => value.attachment;
  int get groupId => value.groupId;
  FeedType get type => value.type;
  String get content => value.content;
  int get childCount => value.childCount;
  DateTime get createdAt => value.createdAt;
  int get createdBy => value.createdBy;
  DateTime? get updatedAt => value.updatedAt;
  int get likeCount => value.likeCount;
  int get dislikeCount => value.dislikeCount;
  bool get isCommentable => value.isCommentable;
  bool get isDeleted => value.isDeleted;
  int get parentId => value.parentId;
  UserInfo get userInfo => value.userInfo;
}

class FeedData {
  late final int id;
  late String attachment;
  late final int groupId;
  late final FeedType type;
  late final String content;
  late int childCount;
  late final DateTime createdAt;
  late final int createdBy;
  DateTime? updatedAt;
  late int likeCount;
  late int dislikeCount;
  late bool isCommentable;
  late bool isDeleted;
  late final int parentId;
  late final UserInfo userInfo;

  FeedData(
      {required this.id,
      this.attachment = '',
      this.groupId = -1,
      this.type = FeedType.NONE,
      this.content = '',
      this.childCount = 0,
      required this.createdAt,
      required this.createdBy,
      this.updatedAt,
      this.likeCount = 0,
      this.dislikeCount = 0,
      this.isCommentable = true,
      this.isDeleted = false,
      required this.parentId,
      required this.userInfo});

  FeedData.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'] ?? -1;
    attachment = json['attachment'] ?? '';
    groupId = json['groupId'] ?? -1;
    type = FeedType.from(json['type']);
    content = json['content'] ?? '';
    childCount = json['childCount'] ?? 0;
    createdAt = DateTime.fromMillisecondsSinceEpoch(
        json['createdAt'] ?? DateTime.now().millisecondsSinceEpoch);
    createdBy = json['createdBy'] ?? -1;
    updatedAt = json['updateAt'] != null
        ? DateTime.fromMillisecondsSinceEpoch(json['updateAt'])
        : null;
    likeCount = json['likeCount'] ?? 0;
    dislikeCount = json['dislikeCount'] ?? 0;
    isCommentable = json['isCommentable'] ?? true;
    isDeleted = json['isDeleted'] ?? false;
    parentId = json['parentId'] ?? -1;
    userInfo = UserInfo.fromJson(json['userInfo'] ?? {});
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['attachment'] = attachment;
    data['groupId'] = groupId;
    data['type'] = type.name;
    data['content'] = content;
    data['childCount'] = childCount;
    data['createdAt'] = createdAt.millisecondsSinceEpoch;
    data['createdBy'] = createdBy;
    data['updatedAt'] = updatedAt?.millisecondsSinceEpoch;
    data['likeCount'] = likeCount;
    data['dislikeCount'] = dislikeCount;
    data['isCommentable'] = isCommentable;
    data['isDeleted'] = isDeleted;
    data['parentId'] = parentId;
    if (userInfo != null) {
      data['userInfo'] = userInfo.toJson();
    }
    return data.json;
  }
}
