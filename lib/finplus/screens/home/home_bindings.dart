import 'package:commons/commons.dart';

import '../community/community_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CommunityController());
  }
}
