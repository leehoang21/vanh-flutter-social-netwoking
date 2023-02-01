library commons;

import 'dart:convert' as j;

import 'package:flutter/foundation.dart';

import 'models/custom_printer.dart';
// ignore: depend_on_referenced_packages
import 'package:logger/logger.dart';

export 'package:get/get.dart';
export 'loading_overlay/loading_overlay.dart';
export 'storage/storage.dart';
export 'package:flutter_svg/flutter_svg.dart';
export 'package:uuid/uuid.dart';
export 'package:logger_flutter/logger_flutter.dart';
export 'package:collection/collection.dart';
export 'package:commons/app_logger/models/network_info.dart';
export 'package:commons/custom_tooltip/custom_tooltip.dart';

abstract class ExtendModel {
  Map toJson();
}

class _CustomFilter extends LogFilter {
  final bool allowPrint;

  _CustomFilter(this.allowPrint);
  @override
  bool shouldLog(LogEvent event) {
    return allowPrint;
  }
}

abstract class AppLoggerDefine {
  final bool allowPrint;
  late final Logger _logger;
  AppLoggerDefine(this.allowPrint) {
    _logger = Logger(
        printer: CustomPrinter(
          printTime: true,
          methodCount: 8,
        ),
        filter: _CustomFilter(allowPrint));
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

  void _log(Level level, dynamic message,
      [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      if (message is List) {
        _logger.log(
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
        _logger.log(level, json.prettyJson, error, stackTrace);
      } else if (message is Iterable<Map>) {
        _logger.log(level, message.map((e) => e.prettyJson).toList(), error,
            stackTrace);
      } else if (message is ExtendModel) {
        _logger.log(level, message.toJson().prettyJson, error, stackTrace);
      } else {
        _logger.log(level, message, error, stackTrace);
      }
    }
  }
}

Uri getUri(String baseUrl, String path, Map<String, String>? query,
    [bool secure = true]) {
  if (secure) {
    return Uri.https(baseUrl, path, query);
  } else {
    return Uri.http(baseUrl, path, query);
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
