import 'package:commons/commons.dart';
import 'package:finplus/base/network/app_connection.dart';
import 'package:finplus/providers/market_provider.dart';

class GlobalController extends GetxController {
  late final MarketProvider _marketProvider;

  @override
  void onInit() {
    _marketProvider = MarketProvider();
    super.onInit();
  }

  @override
  void onReady() {
    AppConnection.addListener((hasConnect) {});

    MarketProvider.addListener((data) {
      logD(data);
    });

    _marketProvider.getSymbolData(['AAA']);
    super.onReady();
  }
}
