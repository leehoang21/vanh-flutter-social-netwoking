library commons;

import 'dart:convert' as j;

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'models/custom_printer.dart';

export 'package:get/get.dart';
export 'loading_overlay/loading_overlay.dart';
export 'storage/storage.dart';
export 'package:flutter_svg/flutter_svg.dart';
export 'package:uuid/uuid.dart';

abstract class ExtendModel {
  Map toJson();
}

final logger = Logger(
  printer: CustomPrinter(
    printTime: true,
    methodCount: 8,
  ),
);

void _log(Level level, dynamic message,
    [dynamic error, StackTrace? stackTrace]) {
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
              .toList(),
          error,
          stackTrace);
    } else if (message is Map) {
      final json = {};
      message.forEach((key, value) {
        json[key] = value is ExtendModel ? value.toJson() : value;
      });
      logger.log(level, json.prettyJson, error, stackTrace);
    } else if (message is Iterable<Map>) {
      logger.log(
          level, message.map((e) => e.prettyJson).toList(), error, stackTrace);
    } else if (message is ExtendModel) {
      logger.log(level, message.toJson().prettyJson, error, stackTrace);
    } else {
      logger.log(level, message, error, stackTrace);
    }
  }
}

void logD(dynamic message) {
  _log(Level.debug, message);
}

void logW(dynamic message) {
  _log(Level.warning, message);
}

void logE(dynamic message, [StackTrace? stackTrace]) {
  _log(Level.error, message, null, stackTrace);
}

Uri getUri(String baseUrl, String path, [bool secure = true]) {
  if (secure) {
    return Uri.https(baseUrl, path);
  } else {
    return Uri.http(baseUrl, path);
  }
}

class Commons {
  static Map<K, V> validateNull<K, V>(Map<K, V> value) {
    value.removeWhere((key, value) {
      return key == null ||
          value == null ||
          value == 'null' ||
          value == '' ||
          value is Map && value.isEmpty ||
          value is List && value.isEmpty;
    });
    return value;
  }
}

extension MapExtension<K, V> on Map<K, V> {
  Map<K, V> get json => Map<K, V>.from(Commons.validateNull(this));
  Map<K, V> get prettyJson =>
      j.json.decode(const j.JsonEncoder.withIndent(' ').convert(this));
}
