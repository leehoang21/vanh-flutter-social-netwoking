// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:commons/commons.dart' hide Response;
import 'package:dio/dio.dart';
import 'package:finplus/base/app_config/app_config.dart';
import 'package:finplus/base/network/app_connection.dart';
import 'package:finplus/models/login_info_data.dart';
import 'package:finplus/routes/finplus_routes.dart';
import 'package:finplus/utils/types.dart';
import 'package:finplus/utils/utils.dart';
import 'package:flutter/foundation.dart';

import '../../utils/app_logger.dart';

const int _maxRetry = 10;

enum METHOD { GET, POST, PUT, DELETE }

class _Dio {
  late final Dio instance;
  static final _Dio _singleton = _Dio._internal();

  factory _Dio() {
    return _singleton;
  }

  _Dio._internal() {
    instance = Dio();
  }
}

class ApiRequest extends ExtendModel {
  final String path;
  final METHOD method;
  final Map<String, String?>? query;
  final Map<String, dynamic>? body;
  late final Map<String, String>? headers;
  final bool auth;

  ApiRequest({
    required this.path,
    required this.method,
    this.query,
    this.body,
    required this.auth,
    this.headers,
  });

  @override
  Map<dynamic, dynamic> toJson() {
    return {
      'method': method.name,
      'path': path,
      'query': query,
      'body': body,
      'extraHeaders': headers,
    };
  }
}

class ApiResponse<T> extends ExtendModel {
  final ApiRequest request;
  final dynamic body;
  final List<T> items;
  final int? statusCode;
  final dynamic undecodeData;
  final Uri realUri;

  ApiResponse({
    required this.request,
    required this.body,
    required this.statusCode,
    this.undecodeData,
    required this.realUri,
    this.items = const [],
  });

  @override
  Map<dynamic, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'realUrl': realUri.toString(),
      'request': request.toJson(),
      'response': {'body': undecodeData}.prettyJson,
    };
  }

  bool get success {
    if (statusCode != 200) {
      logW(toJson());
    }
    return statusCode == 200;
  }

  bool get error => !success;

  void showNotification() {
    Utils.showNotification(undecodeData is Map ? undecodeData['code'] : null);
  }
}

abstract class BaseNetWork {
  final _Dio _dio;

  final String? baseUrl;

  final bool? secure;

  int get maxRetry => _maxRetry;

  Duration get retryDelay => const Duration(seconds: 3);

  BaseNetWork({this.baseUrl, this.secure}) : _dio = _Dio() {
    _dio.instance.interceptors.add(_auththenticationInterceptor);
  }

  Future<ApiResponse<R>> sendRequest<R>(ApiRequest request,
      {R Function(Map)? decoder, bool disableRetry = false}) async {
    try {
      final uri = getUri(baseUrl ?? AppConfig.info.baseUrl, request.path,
          secure ?? AppConfig.info.secure);

      final data = await _dio.instance.request(
        uri.toString(),
        data: request.body,
        queryParameters: request.query,
        options: Options(
          method: request.method.name,
          headers: request.headers,
          extra: {'auth': request.auth, 'disableRetry': disableRetry},
          sendTimeout: 3000,
          receiveTimeout: 30000,
        ),
      );

      final dynamic body;
      final List<R> items = [];

      if (decoder != null) {
        if (data.data is List) {
          body = data.data;
          items.addAll((data.data as List).map((e) => decoder(e)));
        } else {
          body = decoder(data.data);
        }
      } else {
        body = data.data;
      }

      return ApiResponse<R>(
        statusCode: data.statusCode,
        body: body,
        undecodeData: data.data,
        request: request,
        realUri: data.realUri,
        items: items,
      );
    } catch (e, stackTrace) {
      final uri = getUri(baseUrl ?? AppConfig.info.baseUrl, request.path,
          secure ?? AppConfig.info.secure);
      e.logEx(stackTrace);
      return ApiResponse(
          request: request, body: null, statusCode: null, realUri: uri);
    }
  }

  QueuedInterceptorsWrapper get _auththenticationInterceptor {
    return QueuedInterceptorsWrapper(
      onRequest: (options, handler) {
        if (options.extra['auth'] == true) {
          options.headers['Authorization'] = _accessToken;
        }
        handler.next(options);
      },
      onResponse: (e, handler) {
        handler.next(e);
      },
      onError: (e, handler) async {
        final bool disableRetry =
            e.requestOptions.extra['disableRetry'] == true;

        if (_checkNeedRetry(e)) {
          if (disableRetry) {
            handler.next(e);
            return;
          }
          final id = const Uuid().v4();

          AppConnection.addListener((hasConnect) async {
            if (hasConnect) {
              final res = await _handleRetry(e.requestOptions);
              handler.resolve(res);

              AppConnection.removeListener(id);
            }
          }, id);
        } else {
          if (e.response != null) {
            if (e.response?.statusCode == 401) {
              handler.resolve(e.response!);
              Storage.delete(KEY.USER_INFO);
              Get.offAllNamed(Routes.login);
            } else {
              int retryCount = 0;

              Response res = e.response!;

              if (disableRetry) {
                handler.resolve(res);
                return;
              }
              while (retryCount < maxRetry) {
                await Future.delayed(retryDelay);
                if (kDebugMode) {
                  print('retry: ${e.requestOptions.uri.toString()}');
                }

                res = await _handleRetry(e.requestOptions);
                if (res.statusCode == 200) {
                  return;
                } else {
                  retryCount++;
                }
              }
              handler.resolve(res);
            }
          } else {
            handler.next(e);
          }
        }
      },
    );
  }

  String? get _accessToken {
    final LoginInfoData? user =
        Storage.get(KEY.USER_INFO, LoginInfoData.fromJson);
    if (user != null) {
      return 'Bearer ${user.accessToken}';
    } else {
      return null;
    }
  }

  bool _checkNeedRetry(DioError e) {
    return e.type == DioErrorType.other && !AppConnection.hasConnection;
  }

  Future<Response> _handleRetry(RequestOptions requestOptions) async {
    final res = await _dio.instance.fetch(requestOptions);

    return res;
  }
}
