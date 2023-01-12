import 'package:finplus/base/app_config/app_config.dart';

void setAppDevelopment() {
  AppConfig(
    env: ENV.DEV,
    baseUrl: '123.31.12.162:3002',
    secure: false,
    marketUrl: 'trading.shs.com.vn',
    marketSecure: true,
    fetchCount: 20,
  );
}
