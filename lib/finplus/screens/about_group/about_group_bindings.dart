import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/about_group/about_group_controller.dart';

class AboutGroupBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AboutGroupController());
  }
}