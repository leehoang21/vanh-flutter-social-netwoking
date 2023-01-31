import 'dart:convert';

import 'package:commons/commons.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class RxChatData extends Rx<ChatData> {
  RxChatData(ChatData initial) : super(initial);

  String get groupId => value.groupId;
  String get chatId => value.chatId;
  String get repId => value.repId;
  List<Resource> get resource => value.resource;
  String get content => value.content;
  String get formatText => value.formatText;
  String get reactId => value.reactId;
  String get editTime => value.editTime;
  String get createTime => value.createTime;
  String get totalThread => value.totalThread;
  String get botMessage => value.botMessage;
  bool get isDelete => value.isDelete;
  String get userId => value.userId;
  String get username => value.username;
  String get userAvatar => value.userAvatar;
  int get coolCount => value.coolCount;
  List<String> get coolList => value.idCoolList;
  int get sleepyCount => value.sleepyCount;
  List<String> get sleepyList => value.idSleepyList;
  int get angryCount => value.angryCount;
  List<String> get angryList => value.idAngryList;
  int get loveCount => value.loveCount;
  List<String> get loveList => value.idLoveList;
  int get funnyCount => value.funnyCount;
  List<String> get funnyList => value.idFunnyList;
  List<Resource> get replyResource => value.replyResource;
  String get replyContent => value.replyContent;
  String get replyFormat => value.replyFormat;
  String get replyCreateTime => value.replyCreateTime;
  String get replyUserId => value.replyUserId;
  String get replyUsername => value.replyUsername;
  String get replyUserAvatar => value.replyUserAvatar;
  num? get downloadProgress => value.downloadProgress;
  DownloadTaskStatus? get downloadTaskStatus => value.downloadTaskStatus;
  String? get filePath => value.filePath;
}

class ChatData extends ExtendModel {
  late final String groupId;
  late final String chatId;
  late final String repId;
  late final List<Resource> resource;
  late String content;
  late String formatText;
  late final String reactId;
  late String editTime;
  late final String createTime;
  late final String totalThread;
  late final String botMessage;
  late bool isDelete;
  late final String userId;
  late final String username;
  late final String userAvatar;
  late int coolCount;
  late List<String> idCoolList = [];
  late int sleepyCount;
  late List<String> idSleepyList = [];
  late int angryCount;
  late List<String> idAngryList = [];
  late int loveCount;
  late List<String> idLoveList = [];
  late int funnyCount;
  late List<String> idFunnyList = [];
  late List<Resource> replyResource;
  late String replyContent;
  late final String replyFormat;
  late final String replyCreateTime;
  late String replyUserId;
  late String replyUsername;
  late final String replyUserAvatar;
  String? taskId;
  DownloadTaskStatus? downloadTaskStatus;
  num? downloadProgress;
  String? filePath;

  ChatData({
    required this.groupId,
    required this.chatId,
    required this.repId,
    required this.resource,
    required this.content,
    this.formatText = '',
    this.reactId = '',
    this.editTime = '',
    required this.createTime,
    this.totalThread = '',
    this.botMessage = '',
    this.isDelete = false,
    required this.userId,
    required this.username,
    required this.userAvatar,
    this.coolCount = 0,
    this.sleepyCount = 0,
    this.angryCount = 0,
    this.loveCount = 0,
    this.funnyCount = 0,
    required this.replyResource,
    this.replyContent = '',
    this.replyFormat = '',
    this.replyCreateTime = '',
    this.replyUserId = '',
    this.replyUsername = '',
    this.replyUserAvatar = '',
  });

  ChatData.fromJson(Map<String, dynamic> json) {
    groupId = json['c0'];
    chatId = json['c1'];
    repId = json['c2'];
    try {
      resource = json['c3'] is String
          ? (json['c3'] as String).isEmpty
              ? []
              : (jsonDecode(json['c3']) as List)
                  .map((e) => Resource.fromJson(e))
                  .toList()
          : json['c3'];
    } catch (e) {
      resource = [];
    }
    content = json['c4'];
    formatText = json['c5'];
    reactId = json['c6'];
    editTime = json['c7'];
    createTime = json['c8'];
    totalThread = json['c9'];
    botMessage = json['c10'];
    isDelete = json['c11'] == 'Y';
    userId = json['c12'];
    username = json['c13'];
    userAvatar = json['c14'];
    coolCount = int.tryParse(json['c15']) ?? 0;
    idCoolList = json['c16'] is String
        ? (json['c16'] as String).isEmpty
            ? []
            : (json['c16'] as String).split(',')
        : json['c16'];
    sleepyCount = int.tryParse(json['c17']) ?? 0;
    idSleepyList = json['c18'] is String
        ? (json['c18'] as String).isEmpty
            ? []
            : (json['c18'] as String).split(',')
        : json['c18'];
    angryCount = int.tryParse(json['c19']) ?? 0;
    idAngryList = json['c20'] is String
        ? (json['c20'] as String).isEmpty
            ? []
            : (json['c20'] as String).split(',')
        : json['c20'];
    loveCount = int.tryParse(json['c21']) ?? 0;
    idLoveList = json['c22'] is String
        ? (json['c22'] as String).isEmpty
            ? []
            : (json['c22'] as String).split(',')
        : json['c22'];
    funnyCount = int.tryParse(json['c23']) ?? 0;
    idFunnyList = json['c24'] is String
        ? (json['c24'] as String).isEmpty
            ? []
            : (json['c24'] as String).split(',')
        : json['c24'];
    replyResource = json['c25'] is String
        ? (json['c25'] as String).isEmpty
            ? []
            : (jsonDecode(json['c25']) as List)
                .map((e) => Resource.fromJson(e))
                .toList()
        : json['c25'];
    replyContent = json['c26'];
    replyFormat = json['c27'];
    replyCreateTime = json['c28'];
    replyUserId = json['c29'];
    replyUsername = json['c30'];
    replyUserAvatar = json['c31'] ?? '';
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['c0'] = groupId;
    data['c1'] = chatId;
    data['c2'] = repId;
    data['c3'] = resource;
    data['c4'] = content;
    data['c5'] = formatText;
    data['c6'] = reactId;
    data['c7'] = editTime;
    data['c8'] = createTime;
    data['c9'] = totalThread;
    data['c10'] = botMessage;
    data['c11'] = isDelete ? 'Y' : 'N';
    data['c12'] = userId;
    data['c13'] = username;
    data['c14'] = userAvatar;
    data['c15'] = coolCount;
    data['c16'] = idCoolList;
    data['c17'] = sleepyCount;
    data['c18'] = idSleepyList;
    data['c19'] = angryCount;
    data['c20'] = idAngryList;
    data['c21'] = loveCount;
    data['c22'] = idLoveList;
    data['c23'] = funnyCount;
    data['c24'] = idFunnyList;
    data['c25'] = replyResource;
    data['c26'] = replyContent;
    data['c27'] = replyFormat;
    data['c28'] = replyCreateTime;
    data['c29'] = replyUserId;
    data['c30'] = replyUsername;
    data['c31'] = replyUserAvatar;
    return data;
  }
}

class Resource {
  String? name;
  String? type;
  String? urlOrigin;
  String? urlThumbnail;
  int? size;
  bool? success;
  Map<String, dynamic>? quick;

  Resource(
      {this.name,
      this.type,
      this.urlOrigin,
      this.urlThumbnail,
      this.size,
      this.success,
      this.quick});

  Resource.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    urlOrigin = json['urlOrigin'];
    urlThumbnail = json['urlThumbnail'];
    size = json['size'];
    success = json['success'];
    quick = json['quick'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = type;
    data['urlOrigin'] = urlOrigin;
    data['urlThumbnail'] = urlThumbnail;
    data['size'] = size;
    data['success'] = success;
    data['quick'] = quick;
    return data;
  }
}
