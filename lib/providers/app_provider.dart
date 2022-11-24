import 'package:commons/commons.dart';
import 'package:finplus/base/base.dart';

class AppProvider extends BaseNetWork {
  Future<void> getData() async {
    try {
      final data = await sendRequest(
          ApiRequest(baseUrl: 'www.google.com', path: '/', method: METHOD.GET));

      if (data.error) {
        logW(data);
      }
    } catch (e) {
      logE(e);
    }
  }
}
