import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/chat/chat_controller.dart';
class ChatBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatController());
  }
}
