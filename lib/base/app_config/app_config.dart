// ignore_for_file: constant_identifier_names

enum ENV { DEV, PROD }

class AppConfig {
  final ENV env;
  final String baseUrl;
  final bool secure;

  static AppConfig? _instance;

  static AppConfig get instance => _instance!;

  factory AppConfig({
    required ENV env,
    required String baseUrl,
    required bool secure,
  }) {
    _instance ??= AppConfig._internal(
      env: env,
      baseUrl: baseUrl,
      secure: secure,
    );
    return _instance!;
  }

  AppConfig._internal({
    required this.env,
    required this.baseUrl,
    required this.secure,
  });
}
