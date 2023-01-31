import 'package:flutter/material.dart';

const Color _grey = Color(0xFFD3D3D3);

class _DarkConfigColor {
  static const Color _primary_01 = Color(0XFF172150);
  static const Color _textDisable = _primary_01;
  static const Color _backgroundColor = _primary_01;
  static const Color _primaryChat = _primary_01;
  static const Color _textContent = _primary_01;
  static const Color _backgroundFailLoad = _grey;
}

class _LightConfigColor {
  static const Color _primary_01 = Color.fromARGB(255, 5, 53, 56);
  static const Color _primary_02 = Color.fromARGB(255, 0, 94, 95);
  static const Color _primary_03 = Color.fromARGB(255, 54, 151, 145);
  static const Color _primary_04 = Color(0xff6fb98f);
  static const Color _secondary_01 = Color.fromARGB(255, 81, 230, 173);
  static const Color _secondary_02 = Color.fromARGB(255, 20, 160, 111);
  static const Color _secondary_03 = Color(0xffb3de81);
  /*Do not change _primaryChat to match _backgroundColor
  _primaryChat is using for many icons in chat*/
  static const Color _primaryChat = _primary_04;
  static const Color _backgroundColor = Color(0xFFFFFFFF);
  static const Color _textDisable = Color(0xFF8691B3);
  static const Color _textContent = Color(0xFF333333);
  static const Color _backgroundFailLoad = _grey;
}

class CommonStyles extends ThemeExtension<CommonStyles> {
  final Color? primary_01;
  final Color? primary_02;
  final Color? primary_03;
  final Color? primary_04;
  final Color? secondary_01;
  final Color? secondary_02;
  final Color? secondary_03;
  final Color background;
  final Color textDisable;
  final Color primaryChat;
  final Color textContent;
  final Color backgroundFailLoad;

  const CommonStyles({
    this.primary_01,
    this.primary_02,
    this.primary_03,
    this.primary_04,
    this.secondary_01,
    this.secondary_02,
    this.secondary_03,
    required this.background,
    required this.textDisable,
    required this.primaryChat,
    required this.textContent,
    required this.backgroundFailLoad,
  });

  factory CommonStyles.dark() {
    return const CommonStyles(
      primary_01: _DarkConfigColor._primary_01,
      background: _DarkConfigColor._backgroundColor,
      textDisable: _DarkConfigColor._textDisable,
      primaryChat: _DarkConfigColor._primaryChat,
      textContent: _DarkConfigColor._textContent,
      backgroundFailLoad: _DarkConfigColor._backgroundFailLoad,
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
      background: _LightConfigColor._backgroundColor,
      textDisable: _LightConfigColor._textDisable,
      primaryChat: _LightConfigColor._primaryChat,
      textContent: _LightConfigColor._textContent,
      backgroundFailLoad: _LightConfigColor._backgroundFailLoad,
    );
  }

  @override
  ThemeExtension<CommonStyles> copyWith({
    Color? primary_01,
  }) =>
      CommonStyles(
        primary_01: primary_01 ?? this.primary_01,
        background: background,
        textDisable: textDisable,
        primaryChat: primaryChat,
        textContent: textContent,
        backgroundFailLoad: backgroundFailLoad,
      );

  @override
  ThemeExtension<CommonStyles> lerp(
      ThemeExtension<CommonStyles>? other, double t) {
    if (other is! CommonStyles) {
      return this;
    }

    return CommonStyles(
      primary_01: Color.lerp(primary_01, other.primary_01, t),
      background: Color.lerp(background, other.background, t) ?? background,
      textDisable: Color.lerp(textDisable, other.textDisable, t) ?? textDisable,
      primaryChat: Color.lerp(primaryChat, other.primaryChat, t) ?? primaryChat,
      textContent: Color.lerp(textContent, other.textContent, t) ?? textContent,
      backgroundFailLoad:
          Color.lerp(backgroundFailLoad, other.backgroundFailLoad, t) ??
              backgroundFailLoad,
    );
  }
}
