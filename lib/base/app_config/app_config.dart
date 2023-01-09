// ignore_for_file: constant_identifier_names

enum ENV { DEV, PROD }

class AppConfig {
  final ENV env;
  final String baseUrl;
  final bool secure;
  final String marketUrl;
  final bool marketSecure;

  static AppConfig? _info;

  static AppConfig get info => _info!;

  factory AppConfig({
    required ENV env,
    required String baseUrl,
    required bool secure,
    required String marketUrl,
    required bool marketSecure,
  }) {
    _info ??= AppConfig._internal(
      env: env,
      baseUrl: baseUrl,
      secure: secure,
      marketUrl: marketUrl,
      marketSecure: marketSecure,
    );
    return _info!;
  }

  AppConfig._internal({
    required this.env,
    required this.baseUrl,
    required this.secure,
    required this.marketUrl,
    required this.marketSecure,
  });
}
