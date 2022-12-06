import 'package:finplus/global.dart';
import 'package:flutter/material.dart';

import 'app/finplus.dart';
import 'config.dart';

Future<void> main() async {
  setAppDevelopment();

  await Global.initial();

  runApp(const FinPlus());
}
