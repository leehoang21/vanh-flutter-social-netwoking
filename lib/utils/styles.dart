import 'package:finplus/models/common_styles.dart';
import 'package:flutter/material.dart';

class Spaces {
  static const Widget box4 = SizedBox.square(dimension: 4);
  static const Widget box6 = SizedBox.square(dimension: 6);
  static const Widget box8 = SizedBox.square(dimension: 8);
  static const Widget box10 = SizedBox.square(dimension: 10);
  static const Widget box12 = SizedBox.square(dimension: 12);
  static const Widget box14 = SizedBox.square(dimension: 14);
  static const Widget box16 = SizedBox.square(dimension: 16);
  static const Widget box20 = SizedBox.square(dimension: 20);
  static const Widget box24 = SizedBox.square(dimension: 24);
  static const Widget box32 = SizedBox.square(dimension: 32);
  static const Widget box36 = SizedBox.square(dimension: 36);
  static const Widget box42 = SizedBox.square(dimension: 42);
  static const Widget box64 = SizedBox.square(dimension: 64);
  static const Widget box96 = SizedBox.square(dimension: 96);

  static const EdgeInsets a4 = EdgeInsets.all(4);
  static const EdgeInsets a8 = EdgeInsets.all(8);
  static const EdgeInsets a16 = EdgeInsets.all(16);

  static const EdgeInsets h8 = EdgeInsets.symmetric(horizontal: 8);
  static const EdgeInsets h16 = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets h20 = EdgeInsets.symmetric(horizontal: 20);

  static const EdgeInsets v8 = EdgeInsets.symmetric(vertical: 8);
  static const EdgeInsets v12 = EdgeInsets.symmetric(vertical: 12);
  static const EdgeInsets v16 = EdgeInsets.symmetric(vertical: 16);

  static const EdgeInsets h16v12 =
      EdgeInsets.symmetric(vertical: 12, horizontal: 16);
  static const EdgeInsets h12v16 =
      EdgeInsets.symmetric(vertical: 16, horizontal: 12);
  static const EdgeInsetsGeometry h16v25 =
      EdgeInsets.symmetric(vertical: 25, horizontal: 16);
}

class Decorate {
  static const BorderRadius r4 = BorderRadius.all(Radius.circular(4));
  static const BorderRadius r8 = BorderRadius.all(Radius.circular(8));
  static const BorderRadius r16 = BorderRadius.all(Radius.circular(16));
  static const BorderRadius r20 = BorderRadius.all(Radius.circular(20));
  static const BorderRadius r24 = BorderRadius.all(Radius.circular(24));
  static const BorderRadius r32 = BorderRadius.all(Radius.circular(32));
  static const BorderRadius r24_top =
      BorderRadius.vertical(top: Radius.circular(24));

  static const BoxDecoration box_r16 = BoxDecoration(
    borderRadius: BorderRadius.all(
      Radius.circular(16),
    ),
  );
  static const BoxDecoration box_r8 = BoxDecoration(
    borderRadius: BorderRadius.all(
      Radius.circular(8),
    ),
  );
}

class TextDefine {
  static const TextStyle H1_bold =
      TextStyle(fontSize: 24, fontWeight: FontWeight.w600);

  static const TextStyle T1_medium =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w500);

  static const TextStyle T1_bold =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w600);

  static const TextStyle T2_medium =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

  static const TextStyle T2_bold =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

  static const TextStyle P1_regular = TextStyle(fontSize: 16);

  static const TextStyle P1_medium =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

  static const TextStyle P1_bold =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

  static const TextStyle P2_regular = TextStyle(fontSize: 14);

  static const TextStyle P2_medium =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w500);

  static const TextStyle P2_bold =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600);

  static const TextStyle P3_regular = TextStyle(fontSize: 12);

  static const TextStyle P3_medium =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w500);

  static const TextStyle P3_bold =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w600);

  static const TextStyle P4_regular =
      TextStyle(fontSize: 10, fontWeight: FontWeight.w400);

  static const TextStyle P4_medium =
      TextStyle(fontSize: 10, fontWeight: FontWeight.w500);

  static const TextStyle P5_medium =
      TextStyle(fontSize: 11, fontWeight: FontWeight.w400);

  static const TextStyle T1 =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w500);

  static const TextStyle H1 =
      TextStyle(fontSize: 24, fontWeight: FontWeight.w600);

  static const TextStyle H4 = TextStyle(fontSize: 14);

  static const TextStyle H1_B =
      TextStyle(fontSize: 24, fontWeight: FontWeight.w700);

  static const TextStyle T1_B =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w700);

  static const TextStyle T1_M =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w500);

  static const TextStyle T2_B =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

  static const TextStyle T2_M =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400);

  static const TextStyle P1_B =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w700);

  static const TextStyle P1_S_B =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

  static const TextStyle P1_M =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

  static const TextStyle P1_R =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400);

  static const TextStyle P2_B =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w700);

  static const TextStyle P2_S_B =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600);

  static const TextStyle P2_M =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w500);

  static const TextStyle P2_R =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w400);

  static const TextStyle P3_B =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w700);

  static const TextStyle P3_S_B =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w600);

  static const TextStyle P3_M =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w500);

  static const TextStyle P3_R =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w400);
}

extension BuildContextExtenion on BuildContext {
  CommonStyles get t => Theme.of(this).extension<CommonStyles>()!;
}
