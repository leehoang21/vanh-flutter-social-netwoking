import 'package:flutter/material.dart';

import '../models/common_styles.dart';

final _lightColor = CommonStyles.light();

ThemeData get lightTheme => ThemeData(
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: _lightColor.primary_01,
        titleSpacing: 0,
      ),
    );
