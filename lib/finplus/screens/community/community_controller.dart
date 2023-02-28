import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/home/home_controller.dart';
import 'package:finplus/providers/community_provider/community_provider.dart';
import 'package:finplus/providers/community_provider/models/feed_data.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommunityController extends GetxController with HomeControllerMinxin {
  late final CommunityProvider _communityProvider;

  late final RefreshController refreshController;

  late final Rx<List<RxFeedData>> feedDataList;

  late final int groupId;

  @override
  void onInit() {
    _communityProvider = CommunityProvider();

    refreshController = RefreshController();

    feedDataList = Rx<List<RxFeedData>>([]);

    groupId = 2;
    super.onInit();
  }

  @override
  void onReady() {
    getFeed();
    super.onReady();
  }

  Future<void> getFeed() async {
    feedDataList.value = await _communityProvider.getFeed(groupId);
  }

  void creatFeed(RxFeedData feedData) {
    feedDataList.update((val) {
      val?.insert(0, feedData);
    });
  }

  Future<void> deletePost(num id) async {
    feedDataList.update((val) {
      val?.removeWhere((element) {
        return element.id == id;
      });
    });
    Get.back(closeOverlays: true, canPop: true);

    await _communityProvider.deleteFeed(id);
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }
}
