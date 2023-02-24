import 'package:flutter/material.dart';

class _DarkConfigColor {
  static const Color _primary_01 = Color(0XFF8fd974);
  static const Color _textDisable = Color(0xFF8691B3);
  static const Color _textContent = Color(0xFF333333);
  static const Color _shadow = Color(0xFFFFFFFF);
}

class _LightConfigColor {
  static const Color _primary_01 = Color(0xff4ca456);
  static const Color _primary_02 = Color(0xff5bb462);
  static const Color _primary_03 = Color(0xff7ac968);
  static const Color _primary_04 = Color(0XFF8fd974);
  static const Color _secondary_01 = Color(0xff009a00);
  static const Color _secondary_02 = Color(0xff99cc00);
  static const Color _secondary_03 = Color(0xffffff02);
  static const Color _textDisable = Color(0xFF718096);
  static const Color _textContent = Color(0xFF1A202C);
  static const Color _shadow = Color(0xFFA0AEC0);
}

class CommonStyles extends ThemeExtension<CommonStyles> {
  final Color primary_02;
  final Color primary_03;
  final Color primary_01;
  final Color primary_04;
  final Color secondary_01;
  final Color secondary_02;
  final Color secondary_03;
  final Color textDisable;
  final Color textContent;
  final Color shadow;

  const CommonStyles({
    required this.primary_01,
    required this.primary_02,
    required this.primary_03,
    required this.primary_04,
    required this.secondary_01,
    required this.secondary_02,
    required this.secondary_03,
    required this.textDisable,
    required this.textContent,
    required this.shadow,
  });

  factory CommonStyles.dark() {
    return const CommonStyles(
      primary_01: _DarkConfigColor._primary_01,
      primary_02: _LightConfigColor._primary_02,
      primary_03: _LightConfigColor._primary_03,
      primary_04: _LightConfigColor._primary_04,
      secondary_01: _LightConfigColor._secondary_01,
      secondary_02: _LightConfigColor._secondary_02,
      secondary_03: _LightConfigColor._secondary_03,
      textDisable: _DarkConfigColor._textDisable,
      textContent: _DarkConfigColor._textContent,
      shadow: _DarkConfigColor._shadow,
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
      textDisable: _LightConfigColor._textDisable,
      textContent: _LightConfigColor._textContent,
      shadow: _LightConfigColor._shadow,
    );
  }

  @override
  ThemeExtension<CommonStyles> copyWith({
    Color? primary_01,
    Color? primary_02,
    Color? primary_03,
    Color? primary_04,
    Color? secondary_01,
    Color? secondary_02,
    Color? secondary_03,
    Color? background,
    Color? textDisable,
    Color? primaryChat,
    Color? textContent,
    Color? backgroundFailLoad,
    Color? shadow,
  }) =>
      CommonStyles(
        primary_01: primary_01 ?? this.primary_01,
        primary_02: primary_02 ?? this.primary_02,
        primary_03: primary_03 ?? this.primary_03,
        primary_04: primary_04 ?? this.primary_04,
        secondary_01: secondary_01 ?? this.secondary_01,
        secondary_02: secondary_02 ?? this.secondary_02,
        secondary_03: secondary_03 ?? this.secondary_03,
        textDisable: textDisable ?? this.textDisable,
        textContent: textContent ?? this.textContent,
        shadow: shadow ?? this.shadow,
      );

  @override
  ThemeExtension<CommonStyles> lerp(
      ThemeExtension<CommonStyles>? other, double t) {
    if (other is! CommonStyles) {
      return this;
    }

    return CommonStyles(
      primary_01: Color.lerp(primary_01, other.primary_01, t) ?? primary_01,
      primary_02: Color.lerp(primary_02, other.primary_02, t) ?? primary_02,
      primary_03: Color.lerp(primary_03, other.primary_03, t) ?? primary_03,
      primary_04: Color.lerp(primary_04, other.primary_04, t) ?? primary_04,
      secondary_01:
          Color.lerp(secondary_01, other.secondary_01, t) ?? secondary_01,
      secondary_02:
          Color.lerp(secondary_02, other.secondary_02, t) ?? secondary_02,
      secondary_03:
          Color.lerp(secondary_03, other.secondary_03, t) ?? secondary_03,
      textDisable: Color.lerp(textDisable, other.textDisable, t) ?? textDisable,
      textContent: Color.lerp(textContent, other.textContent, t) ?? textContent,
      shadow: Color.lerp(shadow, other.shadow, t) ?? shadow,
    );
  }
}
