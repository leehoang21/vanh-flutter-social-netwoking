import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/group/group_controller.dart';

class GroupBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GroupController());
  }
}
