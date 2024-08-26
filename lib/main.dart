import 'package:finplus/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';
import 'config.dart';
import 'firebase_options.dart';

void main() async {
  setAppDevelopment();
  await Global.initial();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance.currentUser;
  print('object');
  runApp(const FinPlus());
}
