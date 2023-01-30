import 'dart:async';

import 'package:finplus/global.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';
import 'config.dart';

Future<void> main() async {
  setAppDevelopment();
  await Global.initial();

  runApp(const FinPlus());
}
