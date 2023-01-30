import 'package:commons/commons.dart';

import '/services/connection_service.dart';
import '/services/global_service.dart';

class FinPlusBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ConnectionService());
    Get.put(GlobalService());
  }
}
