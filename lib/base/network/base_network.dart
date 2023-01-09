// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:io';

import 'package:commons/commons.dart' hide Response;
import 'package:dio/dio.dart';
import 'package:finplus/base/app_config/app_config.dart';
import 'package:finplus/base/network/app_connection.dart';
import 'package:finplus/utils/utils.dart';

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
  final dynamic Function(Map json)? decoder;

  ApiRequest({
    required this.path,
    required this.method,
    this.query,
    this.body,
    required this.auth,
    this.decoder,
    this.headers,
  });

  @override
  Map<dynamic, dynamic> toJson() {
    return {
      'method': method.name,
      'path': path,
      'query': query,
      'body': body,
      'headers': headers,
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

  BaseNetWork({this.baseUrl, this.secure}) : _dio = _Dio() {
    _dio.instance.interceptors.add(_auththenticationInterceptor);
  }

  Future<ApiResponse<R>> sendRequest<R>(ApiRequest request) async {
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
          extra: {'auth': request.auth},
        ),
      );

      final dynamic body;
      final List<R> items = [];

      if (request.decoder != null) {
        if (data.data is List) {
          body = data.data;
          items.addAll((data.data as List).map((e) => request.decoder!(e)));
        } else {
          body = request.decoder!(data.data);
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
        handler.next(options);
      },
      onResponse: (e, handler) {
        handler.next(e);
      },
      onError: (e, handler) {
        if (_checkNeedRetry(e)) {
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
            } else {
              handler.resolve(e.response!);
            }
          } else {
            logE(e);
            handler.next(e);
          }
        }
      },
    );
  }

  bool _checkNeedRetry(DioError e) {
    return e.type == DioErrorType.other && e.error is SocketException;
  }

  Future<Response> _handleRetry(RequestOptions requestOptions) async {
    final res = await _dio.instance.fetch(requestOptions);

    return res;
  }
}

extension ApiResponseExtension on ApiResponse {
  List<T> toList<T>() =>
      body is List ? (body as List).map((e) => e as T).toList() : [];
}
