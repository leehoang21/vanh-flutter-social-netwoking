import 'dart:convert';

import 'package:commons/commons.dart';

// ignore: camel_case_types
enum SYMBOL_TYPE {
  STOCK,
  FUND,
  FUTURES,
  INDEX,
  ETF,
  CW,
  BOND;

  factory SYMBOL_TYPE.from(String? name) {
    return values.firstWhereOrNull((element) => element.name == name) ??
        SYMBOL_TYPE.STOCK;
  }
}

enum MARKET {
  HOSE,
  HNX,
  UPCOM;

  factory MARKET.from(String? name) {
    return values.firstWhereOrNull((element) => element.name == name) ??
        MARKET.HOSE;
  }
}

// ignore: camel_case_types
enum REALTIME_CHANNEL_DATA_TYPE {
  QUOTE,
  BID_OFFER;

  factory REALTIME_CHANNEL_DATA_TYPE.from(String? name) {
    return values.firstWhereOrNull((element) => element.name == name) ??
        REALTIME_CHANNEL_DATA_TYPE.QUOTE;
  }
}

class SymbolData extends ExtendModel {
  late String code;
  num? last;
  num? change;
  num? rate;
  num? open;
  num? high;
  num? low;
  num? reference;
  num? floor;
  num? ceiling;
  num? tradingVolume;
  num? tradingValue;
  num? matchedVolume;
  num? foreignBuyVolume;
  num? foreignSellVolume;
  num? foreignBuyValue;
  num? foreignSellValue;
  num? frTotalRoom;
  num? frCurrentRoom;
  num? vor;
  num? varate;
  num? bbv1;
  num? bbv2;
  num? bbv3;
  num? bov1;
  num? bov2;
  num? bov3;
  num? bbp1;
  num? bbp2;
  num? bbp3;
  num? bop1;
  num? bop2;
  num? bop3;
  num? totalBidVolume;
  num? totalAskVolume;
  num? estimatedPrice;
  num? totalForeign;
  SYMBOL_TYPE? type;
  MARKET? market;
  late List<BidOffer> bb;
  late List<BidOffer> bo;
  W52? w52;
  String? n1;
  String? n2;
  String? icon;
  String? mb;
  num? prvo;
  num? average;
  REALTIME_CHANNEL_DATA_TYPE? channelType;
  Ic? ic;

  SymbolData({
    required this.code,
    this.last,
    this.change,
    this.rate,
    this.open,
    this.high,
    this.low,
    this.tradingVolume,
    this.tradingValue,
    this.reference,
    this.floor,
    this.ceiling,
    this.bb = const [],
    this.bo = const [],
    this.w52,
    this.type,
    this.market,
    this.matchedVolume,
    this.n1,
    this.n2,
    this.foreignBuyVolume,
    this.foreignSellVolume,
    this.channelType,
    this.mb,
    this.ic,
    this.vor,
    this.varate,
  });

  SymbolData.fromJson(Map<dynamic, dynamic> json) {
    code = json['s'];
    last = json['c'];
    change = json['ch'];
    rate = json['r'];
    open = json['o'];
    high = json['h'];
    low = json['l'];
    tradingVolume = json['vo'];
    tradingValue = json['va'];
    reference = json['re'];
    floor = json['fl'];
    ceiling = json['ce'];
    foreignBuyVolume = json['frBvo'];
    foreignSellVolume = json['frSvo'];
    foreignBuyValue = json['frBva'];
    foreignSellValue = json['frSva'];
    frTotalRoom = json['frTr'];
    frCurrentRoom = json['frCr'];
    prvo = json['prvo'];
    average = json['a'];
    totalBidVolume = json['tbo'];
    totalAskVolume = json['too'];
    mb = json['mb'];
    varate = json['var'];
    vor = json['vor'];
    estimatedPrice = json['ep'];

    type = SYMBOL_TYPE.from(json['m']);
    matchedVolume = json['mv'];
    bb = [];

    if (json['bb'] != null) {
      (json['bb'] as List).asMap().forEach((index, v) {
        switch (index) {
          case 0:
            bbp1 = v['p'];
            bbv1 = v['v'];
            break;
          case 1:
            bbp2 = v['p'];
            bbv2 = v['v'];
            break;
          case 2:
            bbp3 = v['p'];
            bbv3 = v['v'];
            break;
          default:
        }
        bb.add(BidOffer.fromJson(v));
      });
    }
    bo = [];

    if (json['bo'] != null) {
      (json['bo'] as List).asMap().forEach((index, v) {
        switch (index) {
          case 0:
            bop1 = v['p'];
            bov1 = v['v'];
            break;
          case 1:
            bop2 = v['p'];
            bov2 = v['v'];
            break;
          case 2:
            bop3 = v['p'];
            bov3 = v['v'];
            break;
          default:
        }
        bo.add(BidOffer.fromJson(v));
      });
    }

    w52 = json['w52'] != null ? W52.fromJson(json['w52']) : W52();
    if (json['n1'] != null && json['n1'].isNotEmpty) {
      try {
        n1 = utf8.decode(json['n1'] is String
            ? (json['n1'] as String).codeUnits
            : json['n1']);
      } catch (e) {
        n1 = json['n1'];
      }
    }
    n2 = json['n2'];
    icon = json['p'];
    channelType = REALTIME_CHANNEL_DATA_TYPE.from(json['channelType']);

    ic = json['ic'] != null ? Ic.fromJson(json['ic']) : null;

    totalForeign = (foreignBuyVolume ?? 0) - (foreignSellVolume ?? 0);
  }

  @override
  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['s'] = code;
    data['c'] = last;
    data['ch'] = change;
    data['r'] = rate;
    data['o'] = open;
    data['h'] = high;
    data['l'] = low;
    data['vo'] = tradingVolume;
    data['va'] = tradingValue;
    data['re'] = reference;
    data['fl'] = floor;
    data['ce'] = ceiling;
    data['t'] = type?.name;
    data['m'] = market?.name;
    data['mv'] = matchedVolume;
    data['totalForeign'] = totalForeign;
    if (bb != null) {
      data['bb'] = bb.map((v) => v.toJson()).toList();
    }
    if (bo != null) {
      data['bo'] = bo.map((v) => v.toJson()).toList();
    }
    if (w52 != null) {
      data['w52'] = w52?.toJson();
    }
    if (n1 != null && n1!.isNotEmpty) {
      data['n1'] = utf8.encode(n1!);
    } else {
      data['n1'] = null;
    }
    data['n2'] = n2;
    data['bvo'] = foreignBuyVolume;
    data['svo'] = foreignSellVolume;
    data['bbv1'] = bbv1;
    data['bbv2'] = bbv2;
    data['bbv3'] = bbv3;
    data['bov1'] = bov1;
    data['bov2'] = bov2;
    data['bov3'] = bov3;
    data['bbp1'] = bbp1;
    data['bbp2'] = bbp2;
    data['bbp3'] = bbp3;
    data['bop1'] = bop1;
    data['bop2'] = bop2;
    data['bop3'] = bop3;
    data['p'] = icon;
    data['frBvo'] = foreignBuyVolume;
    data['frSvo'] = foreignSellVolume;
    data['frBva'] = foreignBuyValue;
    data['frSva'] = foreignSellValue;
    data['frTr'] = frTotalRoom;
    data['frCr'] = frCurrentRoom;
    data['prvo'] = prvo;
    data['a'] = average;
    data['tbo'] = totalBidVolume;
    data['too'] = totalAskVolume;
    data['mb'] = mb;
    data['channelType'] = channelType?.name;
    data['ic'] = ic?.toJson();
    data['var'] = varate;
    data['vor'] = vor;
    data['ep'] = estimatedPrice;

    return data.json;
  }

  Map<String, dynamic> initJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['s'] = code;
    data['m'] = market?.name;
    data['t'] = type?.name;
    data['re'] = reference;
    data['fl'] = floor;
    data['ce'] = ceiling;
    data['prvo'] = prvo;

    return data.json;
  }
}

class BidOffer {
  num? p;
  num? v;
  num? c;

  BidOffer({this.p, this.v, this.c});

  BidOffer.fromJson(Map<dynamic, dynamic> json) {
    p = json['p'];
    v = json['v'];
    c = json['c'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['p'] = p;
    data['v'] = v;
    data['c'] = c;

    return data.json;
  }
}

class W52 {
  num? h;
  num? l;

  W52({this.h, this.l});

  W52.fromJson(Map<dynamic, dynamic> json) {
    h = json['h'];
    l = json['l'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['h'] = h;
    data['l'] = l;

    return data.json;
  }
}

class Ic {
  num? ce;
  num? fl;
  num? up;
  num? dw;
  num? uc;

  Ic({this.ce, this.fl, this.up, this.dw, this.uc});

  Ic.fromJson(Map<dynamic, dynamic> json) {
    ce = json['ce'];
    fl = json['fl'];
    up = json['up'];
    dw = json['dw'];
    uc = json['uc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ce'] = ce;
    data['fl'] = fl;
    data['up'] = up;
    data['dw'] = dw;
    data['uc'] = uc;
    return data;
  }
}
