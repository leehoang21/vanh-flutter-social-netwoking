import 'package:commons/commons.dart';
import 'package:finplus/providers/market_provider/market_provider.dart';

class GlobalService extends GetxController {
  late final MarketProvider _marketProvider;

  @override
  void onInit() {
    _marketProvider = MarketProvider();
    super.onInit();
  }

  @override
  void onReady() {
    MarketProvider.addListener((data) {});

    super.onReady();
  }
}
