import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/group_member_management/group_member_management_controller.dart';

class GroupMemberManagementBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GroupMemberManagementController());
  }
}
