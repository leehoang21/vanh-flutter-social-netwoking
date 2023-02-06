import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/create_post/create_post_controller.dart';

import '../community/community_controller.dart';
import 'home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => CommunityController());
    Get.lazyPut(() => CreatePostController());
  }
}
