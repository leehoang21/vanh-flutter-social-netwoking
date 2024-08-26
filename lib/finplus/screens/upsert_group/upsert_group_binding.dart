import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/upsert_group/upsert_group_controller.dart';

class UpsertGroupBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpsertGroupController());
  }
}
