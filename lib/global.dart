import 'package:commons/commons.dart';
import 'package:flutter/material.dart';

class Global {
  static Future<void> initial() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Storage.init();
    LoadingOverlay();
  }
}
