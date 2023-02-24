import 'package:commons/commons.dart';
import 'package:finplus/models/login_info_data.dart';
import 'package:finplus/utils/app_logger.dart';

import '/base/app_config/app_config.dart';
import '/base/base.dart';
import '../api_path.dart';
import 'models/feed_data.dart';

class CommunityProvider extends BaseNetWork {
  Future<List<RxFeedData>> getFeed({int groupId = 2}) async {
    final params = {
      'fetchCount': AppConfig.info.fetchCount.toString(),
      'groupId': groupId.toString()
    };

    final ApiRequest req = ApiRequest(
      path: ApiPath.feed,
      method: METHOD.GET,
      auth: true,
      query: params,
    );

    final res = await sendRequest(req, decoder: FeedData.fromJson);

    if (res.success) {
      return res.items.map((e) => RxFeedData(e)).toList();
    } else {
      return [];
    }
  }

  Future<dynamic> postReactFeed(num feedId, FEED_REACT action) async {
    final params = {'feedId': feedId, 'action': action.name};

    final ApiRequest req = ApiRequest(
      path: ApiPath.feed_react,
      method: METHOD.POST,
      auth: true,
      body: params,
    );

    final res = await sendRequest(req);

    if (res.success) {
      return res;
    } else {
      return [];
    }
  }

  Future<dynamic> deleteFeed(num feedId) async {
    final params = {'feedId': feedId.toString()};
    final ApiRequest req = ApiRequest(
      path: ApiPath.feed,
      method: METHOD.DELETE,
      auth: true,
      query: params,
    );

    final res = await sendRequest(req);

    if (res.success) {
      logD(res);
      return res;
    } else {
      return [];
    }
  }

  Future<RxFeedData?> createFeed({
    required final int groupId,
    required final String content,
    required final FEED_TYPE type,
    required final UserInfo userInfo,
    final String? attachment,
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
      return RxFeedData(FeedData(
          content: content,
          attachment: attachment ?? '',
          children: [],
          reactList: ReactData(userDislike: [], userLike: []),
          id: res.body['feedId'],
          createdAt: DateTime.now(),
          createdBy: userInfo.id,
          parentId: res.body['feedId'],
          userInfo: userInfo));
    } else {
      return null;
    }
  }
}
