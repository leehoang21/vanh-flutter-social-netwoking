import 'package:commons/commons.dart';

import 'create_post_controller.dart';

class CreatePostBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreatePostController());
  }
}