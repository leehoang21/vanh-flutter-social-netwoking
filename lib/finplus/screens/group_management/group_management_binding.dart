import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/group_management/group_management_controller.dart';

class GroupManagementBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GroupManagementController());
  }
}
