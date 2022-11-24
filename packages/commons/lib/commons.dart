library commons;

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'models/custom_printer.dart';

export 'package:get/get.dart';
export 'loading_overlay/loading_overlay.dart';
export 'storage/storage.dart';

abstract class ExtendModel {
  Map toJson();
}

final logger = Logger(
  printer: CustomPrinter(
    printTime: true,
    methodCount: 8,
  ),
);

void _log(Level level, dynamic message) {
  if (kDebugMode) {
    if (message is List) {
      logger.log(
          level,
          message
              .map((e) => e is Map
                  ? e.prettyJson
                  : e is ExtendModel
                      ? e.toJson()
                      : e)
              .toList());
    } else if (message is Map) {
      final json = {};
      message.forEach((key, value) {
        json[key] = value is ExtendModel ? value.toJson() : value;
      });
      logger.log(level, json.prettyJson);
    } else if (message is Iterable<Map>) {
      logger.log(level, message.map((e) => e.prettyJson).toList());
    } else if (message is ExtendModel) {
      logger.log(level, message.toJson().prettyJson);
    } else {
      logger.log(level, message);
    }
  }
}

void logD(dynamic message) {
  _log(Level.debug, message);
}

void logW(dynamic message) {
  _log(Level.warning, message);
}

void logE(dynamic message) {
  _log(Level.error, message);
}

Uri getUri(String baseUrl, String path, [bool secure = true]) {
  if (secure) {
    return Uri.https(baseUrl, path);
  } else {
    return Uri.http(baseUrl, path);
  }
}

extension MapExtension<K, V> on Map<K, V> {
  Map<K, V> get prettyJson =>
      json.decode(const JsonEncoder.withIndent('    ').convert(this));
}
