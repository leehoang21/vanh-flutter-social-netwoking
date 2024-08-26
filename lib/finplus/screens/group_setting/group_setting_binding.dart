import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/group_setting/group_setting_controller.dart';

class GroupSettingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GroupSettingController());
  }
}
