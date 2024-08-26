import 'package:commons/commons.dart';

import '../../utils/svg.dart';

// ignore: camel_case_types
enum GROUP_PRIVACY {
  PUBLIC(
    icon: SvgIcon.public_icon,
    title: 'Công khai',
    desc:
        'Chỉ thành viêng mới nhìn thấy các bài viết trong nhóm và những gì họ đăng',
  ),
  PRIVATE(
    icon: SvgIcon.private,
    title: 'Riêng tư',
    desc:
        'Chỉ thành viêng mới nhìn thấy các bài viết trong nhóm và những gì họ đăng',
  );

  final String icon;
  final String title;
  final String desc;

  const GROUP_PRIVACY({
    required this.icon,
    required this.title,
    required this.desc,
  });
}

class RxGroupInfoData extends Rx<GroupInfoData> {
  RxGroupInfoData(super.initial);

  int get id => value.id;
  String get name => value.name;
  GROUP_PRIVACY get privacy => value.privacy;
  String get about => value.about;
  String get rule => value.rule;
  int get members => value.members;
  int get followers => value.followers;
  int? get pinFeedId => value.pinFeedId;
  int get createdBy => value.createdBy;
  int? get updatedBy => value.updatedBy;
  int get createdAt => value.createdAt;
  int? get updatedAt => value.updatedAt;
  bool get isJoined => value.isJoined;
  bool get isFollowing => value.isFollowing;
  List<GroupUser> get groupUsers => value.groupUsers;
  List<int> get adminsGroup => value.adminsGroup;
  List<int> get managersGroup => value.managersGroup;
}

class GroupInfoData {
  late final int id;
  late String name;
  late GROUP_PRIVACY privacy;
  late String about;
  late String rule;
  late int members;
  late int followers;
  late int? pinFeedId;
  late final int createdBy;
  late int? updatedBy;
  late final int createdAt;
  late int? updatedAt;
  late bool isJoined;
  late bool isFollowing;
  late List<GroupUser> groupUsers;
  late List<int> adminsGroup;
  late List<int> managersGroup;

  GroupInfoData({
    required this.id,
    this.name = '',
    required this.privacy,
    this.about = '',
    this.rule = '',
    this.members = 0,
    this.followers = 0,
    this.pinFeedId,
    required this.createdBy,
    this.updatedBy,
    required this.createdAt,
    this.updatedAt,
    this.isJoined = true,
    this.isFollowing = true,
    this.groupUsers = const [],
    this.adminsGroup = const [],
    this.managersGroup = const [],
  });

  GroupInfoData.fromJson(Map<dynamic, dynamic> json) {
    final List list = json['groupUsers'] as List;
    id = json['id'] ?? -1;
    name = json['name'] ?? '';
    privacy = json['privacy'] == 'PUBLIC'
        ? GROUP_PRIVACY.PUBLIC
        : GROUP_PRIVACY.PRIVATE;
    about = json['about'] ?? '';
    rule = json['rule'] ?? '';
    members = json['members'] ?? 0;
    followers = json['followers'] ?? 0;
    pinFeedId = json['pinFeedId'];
    createdBy = json['createdBy'] ?? '';
    updatedBy = json['updatedBy'];
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'];
    isJoined = json['isJoined'] ?? true;
    isFollowing = json['isFollowing'] ?? true;
    list != null
        ? groupUsers = list.map((e) => GroupUser.fromJson(e)).toList()
        // ignore: unnecessary_statements
        : [];
    adminsGroup = json['adminsGroup']?.cast<int>() ?? [];
    managersGroup = json['managersGroup']?.cast<int>() ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['privacy'] = privacy;
    data['about'] = about;
    data['rule'] = rule;
    data['members'] = members;
    data['followers'] = followers;
    data['pinFeedId'] = pinFeedId;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['isJoined'] = isJoined;
    data['isFollowing'] = isFollowing;
    data['groupUsers'] = groupUsers;
    data['adminsGroup'] = adminsGroup;
    data['managersGroup'] = managersGroup;
    return data;
  }
}

class GroupUser {
  late int userId;
  late String role;

  GroupUser({
    required this.userId,
    required this.role,
  });

  GroupUser.fromJson(Map<dynamic, dynamic> json) {
    userId = json['userId'] ?? -1;
    role = json['role'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['role'] = role;
    return data;
  }
}
