import 'package:commons/commons.dart';
import 'package:commons/os_info/os_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'base/network/app_connection.dart';
import 'firebase_options.dart';

class Global {
  static Future<void> initial() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Storage.init();
    await OsInfo.init();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    
    AppConnection.initial();

    LoadingOverlay();
  }
}
