import 'package:finplus/global.dart';
import 'package:flutter/material.dart';

import 'app/finplus.dart';
import 'config.dart';
import 'providers/app_provider.dart';

Future<void> main() async {
  setAppDevelopment();

  await Global.initial();

  AppProvider().getData();
  runApp(const FinPlus());
}
