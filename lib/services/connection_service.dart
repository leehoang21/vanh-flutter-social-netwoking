import 'package:commons/commons.dart';
import 'package:finplus/base/network/app_connection.dart';
import 'package:finplus/utils/utils.dart';

class ConnectionService extends GetxService {
  @override
  void onInit() {
    AppConnection.addListener(_onChangedConnection);
    super.onInit();
  }

  void _onChangedConnection(bool hasConnect) {
    if (!hasConnect) {
      Utils.showNotification('Mất kết nối internet!');
    }
  }
}
