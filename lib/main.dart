import 'dart:async';

import 'package:commons/commons.dart';
import 'package:finplus/global.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';
import 'config.dart';

Future<void> main() async {
  setAppDevelopment();

  AppLogger.startLogger(
    onInitial: Global.initial,
    const FinPlus(),
  );
}
