import 'package:commons/commons.dart';

import '../community/community_controller.dart';
import 'home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.lazyPut(() => CommunityController());
  }
}
