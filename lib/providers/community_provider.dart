import 'package:finplus/base/app_config/app_config.dart';
import 'package:finplus/base/base.dart';

import '../models/feed_data.dart';
import 'api_path.dart';

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
}
