import 'package:flutter/material.dart';

class _DarkConfigColor {
  static const Color _primary_01 = Color(0XFF172150);
}

class _LightConfigColor {
  static const Color _primary_01 = Color.fromARGB(255, 5, 53, 56);
  static const Color _primary_02 = Color.fromARGB(255, 0, 94, 95);
  static const Color _primary_03 = Color.fromARGB(255, 54, 151, 145);
  static const Color _primary_04 = Color(0xff6fb98f);
  static const Color _secondary_01 = Color.fromARGB(255, 81, 230, 173);
  static const Color _secondary_02 = Color.fromARGB(255, 20, 160, 111);
  static const Color _secondary_03 = Color(0xffb3de81);
}

class CommonStyles extends ThemeExtension<CommonStyles> {
  final Color? primary_01;
  final Color? primary_02;
  final Color? primary_03;
  final Color? primary_04;
  final Color? secondary_01;
  final Color? secondary_02;
  final Color? secondary_03;

  const CommonStyles({
    this.primary_01,
    this.primary_02,
    this.primary_03,
    this.primary_04,
    this.secondary_01,
    this.secondary_02,
    this.secondary_03,
  });

  factory CommonStyles.dark() {
    return const CommonStyles(
      primary_01: _DarkConfigColor._primary_01,
    );
  }

  factory CommonStyles.light() {
    return const CommonStyles(
      primary_01: _LightConfigColor._primary_01,
      primary_02: _LightConfigColor._primary_02,
      primary_03: _LightConfigColor._primary_03,
      primary_04: _LightConfigColor._primary_04,
      secondary_01: _LightConfigColor._secondary_01,
      secondary_02: _LightConfigColor._secondary_02,
      secondary_03: _LightConfigColor._secondary_03,
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
