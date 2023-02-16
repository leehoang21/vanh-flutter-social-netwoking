import 'package:commons/commons.dart';
import 'package:finplus/models/login_info_data.dart';

import '/base/app_config/app_config.dart';
import '/base/base.dart';
import '../api_path.dart';
import 'models/feed_data.dart';

// ignore: camel_case_types
enum FEED_TYPE { POST, COMMENT, REPLY }

class CommunityProvider extends BaseNetWork {
  Future<List<RxFeedData>> getFeed() async {
    final params = {'fetchCount': AppConfig.info.fetchCount};

    final ApiRequest req = ApiRequest(
      path: ApiPath.feed,
      method: METHOD.GET,
      auth: true,
      body: params,
    );

    final res = await sendRequest(req, decoder: FeedData.fromJson);

    if (res.success) {
      return res.items.map((e) => RxFeedData(e)).toList();
    } else {
      return [];
    }
  }

  Future<FeedData?> createFeed({
    required final int groupId,
    required final String content,
    required final FEED_TYPE type,
    required final UserInfo userInfo,
    final List<String>? attachment,
    final int? parentId,
    final bool isCommentable = true,

  }) async {
    final params = {
      'groupId': groupId,
      'content': content,
      'type': type.name,
      'attachment': attachment,
      'parentId': parentId,
      'isCommentable': isCommentable
    }.json;

    final ApiRequest req = ApiRequest(
      path: ApiPath.feed,
      method: METHOD.POST,
      auth: true,
      body: params,
    );

    final res = await sendRequest(req);
    if (res.success) {
      return FeedData(id: res.body['feedId'], createdAt: DateTime.now(), createdBy: userInfo.id, parentId: res.body['feedId'], userInfo: userInfo);
    } else {
      return null;
    }
  }
}
