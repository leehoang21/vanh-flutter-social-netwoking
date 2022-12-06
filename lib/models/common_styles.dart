import 'package:flutter/material.dart';

class _DarkConfigColor {
  static const Color _primary_01 = Color(0XFF172150);
}

class _LightConfigColor {
  static const Color _primary_01 = Color(0XFF17434F);
}

class CommonStyles extends ThemeExtension<CommonStyles> {
  final Color? primary_01;

  const CommonStyles({
    this.primary_01,
  });

  factory CommonStyles.dark() {
    return const CommonStyles(
      primary_01: _DarkConfigColor._primary_01,
    );
  }

  factory CommonStyles.light() {
    return const CommonStyles(
      primary_01: _LightConfigColor._primary_01,
    );
  }

  @override
  ThemeExtension<CommonStyles> copyWith({
    Color? primary_01,
  }) =>
      CommonStyles(
        primary_01: primary_01 ?? this.primary_01,
      );

  @override
  ThemeExtension<CommonStyles> lerp(
      ThemeExtension<CommonStyles>? other, double t) {
    if (other is! CommonStyles) {
      return this;
    }

    return CommonStyles(
      primary_01: Color.lerp(primary_01, other.primary_01, t),
    );
  }
}
