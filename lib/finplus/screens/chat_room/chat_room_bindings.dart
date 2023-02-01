import 'package:get/get.dart';

import 'chat_room_controller.dart';

class ChatRoomBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatRoomController());
  }
}
