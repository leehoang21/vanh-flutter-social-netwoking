import 'package:commons/commons.dart';

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

  Future<void> createFeed({
    required final int groupId,
    required final String content,
    required final FEED_TYPE type,
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

    final res = await sendRequest(req, decoder: FeedData.fromJson);
  }
}
