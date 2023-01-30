import 'package:commons/commons.dart';
import 'package:finplus/providers/community_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommunityController extends GetxController {
  late final CommunityProvider _communityProvider;

  late final RefreshController refreshController;

  @override
  void onInit() {
    _communityProvider = CommunityProvider();

    refreshController = RefreshController();

    super.onInit();
  }

  @override
  void onReady() {
    getFeed();
    super.onReady();
  }

  void getFeed() {
    _communityProvider.getFeed();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }
}
