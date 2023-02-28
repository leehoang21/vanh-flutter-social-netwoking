import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/feed_detail/feed_detail_controller.dart';

class FeedDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FeedDetailController());
  }
}
