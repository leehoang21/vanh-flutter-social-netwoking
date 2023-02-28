import 'package:commons/commons.dart';

import '../../../models/login_info_data.dart';

// ignore: camel_case_types
enum FEED_TYPE {
  POST,
  COMMENT,
  REPLY;

  factory FEED_TYPE.from(String? value) =>
      values.firstWhereOrNull((element) => element.name == value) ??
      FEED_TYPE.POST;
}

// ignore: camel_case_types
enum FEED_REACT {
  LIKE,
  DISLIKE,
  DELETE;

  factory FEED_REACT.from(String? value) =>
      values.firstWhereOrNull((element) => element.name == value) ??
      FEED_REACT.LIKE;
}

class RxFeedData extends Rx<FeedData> {
  RxFeedData(super.initial);

  int get id => value.id;
  String get attachment => value.attachment;
  int get groupId => value.groupId;
  FEED_TYPE get type => value.type;
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
  List<FeedData> get children => value.children;
  ReactData get reactList => value.reactList;
}

class FeedData {
  late final int id;
  late String attachment;
  late final int groupId;
  late final FEED_TYPE type;
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
  late final List<FeedData> children;
  late final ReactData reactList;
  late String symbolTags;
  FeedData(
      {required this.id,
      this.attachment = '',
      this.groupId = -1,
      this.type = FEED_TYPE.POST,
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
      required this.userInfo,
      required this.children,
      required this.reactList,
      this.symbolTags = ''});

  FeedData.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'] ?? -1;
    attachment = json['attachment'] ?? '';
    groupId = json['groupId'] ?? -1;
    type = FEED_TYPE.from(json['type']);
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
    children = (json['children'] as List?)
            ?.map((e) => FeedData.fromJson(e))
            .toList() ??
        [];
    reactList = ReactData.fromJson(json['reactList'] ?? {});
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
    data['children'] = children;
    data['reactList'] = reactList;
    data['symbolTags'] = symbolTags;
    return data.json;
  }
}

class ReactData {
  late final List<UserLike> userLike;
  late final List<UserLike> userDislike;

  ReactData({required this.userLike, required this.userDislike});

  ReactData.fromJson(Map<String, dynamic> json) {
    userLike = <UserLike>[];
    if (json['userLike'] != null) {
      json['userLike'].forEach((v) {
        userLike.add(UserLike.fromJson(v));
      });
    }
    userDislike = <UserLike>[];
    if (json['userDislike'] != null) {
      json['userDislike'].forEach((v) {
        userDislike.add(UserLike.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userLike != null) {
      data['userLike'] = userLike.map((v) => v.toJson()).toList();
    }
    if (userDislike != null) {
      data['userDislike'] = userDislike.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserLike {
  late final int feedId;
  late final int id;
  late final FEED_REACT action;
  late final int createdAt;
  late final int userId;

  UserLike(
      {this.feedId = -1,
      this.id = -1,
      this.action = FEED_REACT.LIKE,
      this.createdAt = 0,
      this.userId = -1});

  UserLike.fromJson(Map<String, dynamic> json) {
    feedId = json['feedId'];
    id = json['id'];
    action = FEED_REACT.from(json['action']);
    createdAt = json['createdAt'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feedId'] = feedId;
    data['id'] = id;
    data['action'] = action.name;
    data['createdAt'] = createdAt;
    data['userId'] = userId;
    return data;
  }
}
