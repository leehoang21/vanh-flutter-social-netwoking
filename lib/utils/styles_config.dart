import 'package:finplus/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/common_styles.dart';

ThemeData get lightTheme {
  final _color = CommonStyles.light();
  final outlineBorder = OutlineInputBorder(
    borderRadius: Decorate.r8,
    borderSide: BorderSide(width: 1, color: _color.primary_03),
  );

  return ThemeData(
    useMaterial3: true,
    colorSchemeSeed: _color.primary_01,
    appBarTheme: AppBarTheme(
      centerTitle: false,
      backgroundColor: _color.secondary_01,
      titleSpacing: 0,
      iconTheme: const IconThemeData(color: Colors.white, opacity: 1),
      actionsIconTheme: const IconThemeData(color: Colors.white, opacity: 1),
      foregroundColor: Colors.white,
      elevation: 4,
      shadowColor: Colors.black,
      surfaceTintColor: _color.secondary_01,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.zero,
      filled: true,
      fillColor: _color.primary_02.withOpacity(0.3),
      border: outlineBorder,
      enabledBorder: outlineBorder,
      focusedBorder: outlineBorder.copyWith(
        borderSide: BorderSide(width: 1, color: _color.secondary_01),
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
    textSelectionTheme: TextSelectionThemeData(cursorColor: _color.primary_03),
    extensions: [_color],
  );
}
