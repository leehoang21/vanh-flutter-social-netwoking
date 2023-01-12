import 'dart:math';

import 'package:commons/commons.dart';
import 'package:finplus/base/app_config/app_config.dart';
import 'package:finplus/base/base.dart';
import 'package:finplus/models/symbol_data.dart';
import 'package:finplus/providers/api_path.dart';

typedef ReceivedSymbolDataFunc = void Function(Map<String, dynamic> data);

class MarketProvider extends BaseNetWork {
  static final List<ReceivedSymbolDataFunc> _listeners = [];

  MarketProvider()
      : super(
            baseUrl: AppConfig.info.marketUrl,
            secure: AppConfig.info.marketSecure);

  Future<void> getSymsolStatic() async {
    final ApiRequest req = ApiRequest(
      path: ApiPath.symbolStatic,
      method: METHOD.GET,
      auth: false,
    );

    final res = await sendRequest(req);

    if (res.success) {}
  }

  Future<void> getSymbolData(List<String> symbolList) async {
    int start = 0;
    int end = min(start + 20, symbolList.length);

    while (end <= symbolList.length) {
      final List<String> subList = symbolList.sublist(start, end);

      getSingleSymbolLastes(subList);

      start = end;
      end = min(start + 20, symbolList.length);

      if (start == end) {
        break;
      }
    }
  }

  Future<List<SymbolData>> getSingleSymbolLastes(
      List<String> symbolList) async {
    final Map<String, String> params =
        {'symbolList': symbolList.join(',')}.json;

    final ApiRequest req = ApiRequest(
      path: ApiPath.symbolLatest,
      method: METHOD.GET,
      auth: false,
      query: params,
    );

    final res = await sendRequest(
      req,
      decoder: SymbolData.fromJson,
    );

    if (res.success) {
      (res.body as List).forEach((e) {
        _listeners.forEach((func) {
          func(e);
        });
      });
      return res.items;
    } else {
      return [];
    }
  }

  static void addListener(ReceivedSymbolDataFunc func) {
    _listeners.add(func);
  }

  static void removeListener(ReceivedSymbolDataFunc func) {
    _listeners.remove(func);
  }
}
