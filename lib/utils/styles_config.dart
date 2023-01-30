import 'package:finplus/utils/styles.dart';
import 'package:flutter/material.dart';

import '../models/common_styles.dart';

ThemeData get lightTheme {
  final _color = CommonStyles.light();
  final outlineBorder = OutlineInputBorder(
    borderRadius: Decorate.r8,
    borderSide: BorderSide(width: 1, color: _color.primary_03!),
  );

  return ThemeData(
    appBarTheme: AppBarTheme(
      centerTitle: false,
      backgroundColor: _color.primary_01,
      titleSpacing: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: Spaces.h8,
      filled: true,
      fillColor: _color.primary_02!.withOpacity(0.3),
      border: outlineBorder,
      enabledBorder: outlineBorder,
      focusedBorder: outlineBorder.copyWith(
        borderSide: BorderSide(width: 2, color: _color.secondary_01!),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: _color.secondary_01,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(borderRadius: Decorate.r8),
        textStyle: TextDefine.T2_B,
      ),
    ),
    textSelectionTheme:
        TextSelectionThemeData(cursorColor: _color.secondary_01),
    extensions: [_color],
  );
}
