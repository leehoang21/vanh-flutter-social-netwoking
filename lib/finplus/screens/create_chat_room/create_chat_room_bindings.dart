import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/create_chat_room/create_chat_room_controller.dart';

class CreateChatRoomBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateChatRoomController(id: 0));
  }
}
