import 'package:commons/commons.dart';
import 'package:commons/os_info/os_info.dart';
import 'package:finplus/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

import 'base/app_config/app_config.dart';
import 'base/network/app_connection.dart';

class Global {
  static Future<void> initial() async {
    WidgetsFlutterBinding.ensureInitialized();
    AppConnection.init();
    await Storage.init();
    await OsInfo.init();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await setupRemoteConfig();

    LoadingOverlay();
  }

  static Future<void> setupRemoteConfig() async {
    try {
      if (AppConfig.info.env == ENV.DEV) {
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
