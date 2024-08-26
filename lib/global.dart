import 'package:commons/app_logger/app_logger.dart';
import 'package:commons/commons.dart';
import 'package:commons/os_info/os_info.dart';
// import 'package:cryptography_flutter/cryptography_flutter.dart';
import 'package:finplus/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'base/app_config/app_config.dart';
import 'base/network/app_connection.dart';
import 'utils/app_logger.dart';

class Global {
  static Future<void> initial() async {
    WidgetsFlutterBinding.ensureInitialized();
    // FlutterCryptography.enable();
    if (AppConfig.info.env == ENV.DEV ||
        (AppConfig.info.env == ENV.PROD && kDebugMode)) AppLogger.init();

    AppConnection.init();
    await OsInfo.init();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await setupRemoteConfig();

    LoadingOverlay(barrierColor: Colors.black26);
  }

  static Future<void> setupRemoteConfig() async {
    try {
      if (AppConfig.info.env == ENV.PROD) {
        await FirebaseRemoteConfig.instance
            .setDefaults(AppConfig.info.getConfig());
        await FirebaseRemoteConfig.instance.setConfigSettings(
            RemoteConfigSettings(
                fetchTimeout: const Duration(seconds: 30),
                minimumFetchInterval: Duration.zero));
        await FirebaseRemoteConfig.instance.fetchAndActivate();
        AppConfig.info.updateConfig(FirebaseRemoteConfig.instance.getAll());
      }
    } catch (e, stackTrace) {
      logE(e, stackTrace);
    }
  }
}
