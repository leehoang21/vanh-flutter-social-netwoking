// ignore_for_file: constant_identifier_names

import 'package:commons/commons.dart';
import 'package:dio/dio.dart';

import '../app_config/app_config.dart';

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
  final String? baseUrl;
  final String path;
  final METHOD method;
  final Map<String, String?>? query;
  final Map<String, dynamic>? body;
  late final Map<String, String>? headers;
  final bool auth;
  final bool? secure;
  final dynamic Function(Map json)? decoder;

  ApiRequest({
    required this.path,
    required this.method,
    this.query,
    this.body,
    this.auth = true,
    this.baseUrl,
    this.decoder,
    this.headers,
    this.secure,
  });

  @override
  Map<dynamic, dynamic> toJson() {
    return {
      'method': method.name,
      'path': path,
      'query': query,
      'body': body,
      'uri': uri.toString(),
      'headers': headers,
    };
  }

  Uri get uri => getUri(baseUrl ?? AppConfig.instance.baseUrl, path,
      secure ?? AppConfig.instance.secure);
}

class ApiResponse<T> extends ExtendModel {
  final ApiRequest request;
  final T body;
  final int? statusCode;
  final dynamic undecodeData;

  ApiResponse({
    required this.request,
    required this.body,
    required this.statusCode,
    this.undecodeData,
  });

  @override
  Map<dynamic, dynamic> toJson() {
    return {
      'statusCode': statusCode,
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
}

abstract class BaseNetWork {
  final _Dio _dio;
  BaseNetWork() : _dio = _Dio() {
    _dio.instance.interceptors.add(_auththenticationInterceptor);
  }

  Future<ApiResponse<R?>> sendRequest<R>(ApiRequest request) async {
    final data = await _dio.instance.request(
      data: request.body,
      queryParameters: request.query,
      request.uri.toString(),
      options: Options(
        method: request.method.name,
        headers: request.headers,
        extra: {'auth': request.auth},
      ),
    );

    final dynamic body;

    if (request.decoder != null) {
      if (data.data is List) {
        body = (data.data as List).map((e) => request.decoder!(e)).toList();
      } else {
        body = request.decoder!(data.data);
      }
    } else {
      body = data.data;
    }

    return ApiResponse(
      statusCode: data.statusCode,
      body: body,
      undecodeData: data.data,
      request: request,
    );
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
      },
    );
  }
}
