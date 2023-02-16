import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/search_group/search_group_controller.dart';

class SearchGroupBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchGroupController());
  }
}