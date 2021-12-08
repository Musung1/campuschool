import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_theme.dart';

class MyTextStyle {
  static const logoText = const TextStyle(
    fontFamily: 'NotoSans',
    fontWeight: FontWeight.w900,
    color: MyColor.primary,
    fontSize: 52,
  );
  static const bigTextButton = const TextStyle(
    fontFamily: 'NotoSans',
    fontWeight: FontWeight.w300,
    color: MyColor.black,
    fontSize: 40,
  );

  static const TextStyle headLine = const TextStyle(
    fontFamily: 'NotoSans',
    fontWeight: FontWeight.w500,
    color: MyColor.black,
    fontSize: 34,
  );

  static const TextStyle headLine6 = const TextStyle(
    fontFamily: 'NotoSans',
    fontWeight: FontWeight.w500,
    color: MyColor.black,
    fontSize: 20,
  );

  // 추가
  static const TextStyle headLine6Bold = const TextStyle(
    fontFamily: 'NotoSans',
    fontWeight: FontWeight.w700,
    color: MyColor.black,
    fontSize: 20,
  );

  static const TextStyle landingTitle = const TextStyle(
    fontFamily: 'NotoSans',
    fontWeight: FontWeight.w700,
    color: MyColor.black,
    fontSize: 28,
  );

  static const TextStyle centerTitle = const TextStyle(
    fontFamily: 'NotoSans',
    fontWeight: FontWeight.w700,
    color: MyColor.black,
    fontSize: 24,
  );

  static const TextStyle bigTextButtonBold = const TextStyle(
    fontFamily: 'NotoSans',
    fontWeight: FontWeight.w700, // +++ 400에서 700으로 바꿈 (by 대성) +++
    color: MyColor.black,
    fontSize: 40,
  );

  static const TextStyle subtitle1 = const TextStyle(
    fontFamily: 'NotoSans',
    fontWeight: FontWeight.w500,
    color: MyColor.black,
    fontSize: 18,
  );

  static const TextStyle subtitle2 = const TextStyle(
    fontFamily: 'NotoSans',
    fontWeight: FontWeight.w300,
    color: MyColor.black,
    fontSize: 16,
  );

  static const TextStyle body1 = const TextStyle(
    fontFamily: 'NotoSans',
    fontWeight: FontWeight.w300,
    color: MyColor.black,
    fontSize: 18,
  );

  static const TextStyle body2 = const TextStyle(
    fontFamily: 'NotoSans',
    fontWeight: FontWeight.w300,
    color: MyColor.black,
    fontSize: 16,
  );

  static const TextStyle hashTag = const TextStyle(
    fontFamily: 'NotoSans',
    fontWeight: FontWeight.w500,
    color: MyColor.black,
    fontSize: 16,
  );

  static const TextStyle buttonText = const TextStyle(
    fontFamily: 'NotoSans', // bold로 바뀜 원래 뭔지 기억 안남..
    fontWeight: FontWeight.bold,
    color: MyColor.black,
    fontSize: 18,
  );

  static const TextStyle chipText = const TextStyle(
    fontFamily: 'NotoSans',
    fontWeight: FontWeight.w500,
    color: MyColor.black,
    fontSize: 16,
  );

  static const TextStyle captionText = const TextStyle(
    fontFamily: 'NotoSans',
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: MyColor.black,
  );

  static const TextStyle overlineText = const TextStyle(
    fontFamily: 'NotoSans',
    fontWeight: FontWeight.w300,
    fontSize: 12,
    color: MyColor.black,
  );

  static TextStyle bigTextButtonNum = GoogleFonts.lato(
      textStyle: const TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 40,
    color: MyColor.black,
  ));

  static TextStyle headLineNum = GoogleFonts.lato(
      textStyle: const TextStyle(
    fontFamily: 'Lato',
    fontWeight: FontWeight.w300,
    fontSize: 34,
    color: MyColor.black,
  ));

  static TextStyle landingTitleNum = GoogleFonts.lato(
      textStyle: const TextStyle(
          fontFamily: 'Lato',
          fontWeight: FontWeight.w300,
          fontSize: 28,
        color: MyColor.black,));

  static TextStyle centerTitleNum = GoogleFonts.lato(
      textStyle: const TextStyle(
          fontWeight: FontWeight.w300, fontSize: 24, color: MyColor.black,));

  static TextStyle subtitle1Num = GoogleFonts.lato(
      textStyle: const TextStyle(
    fontFamily: 'Lato',
    fontWeight: FontWeight.w300,
    fontSize: 16,
  ));

  static TextStyle subtitle2Num = GoogleFonts.lato(
      textStyle: const TextStyle(
    fontFamily: 'Lato',
    fontWeight: FontWeight.w300,
    fontSize: 16, // 14->16
  ));

  static TextStyle body1Num = GoogleFonts.lato(
      textStyle: const TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 18,
  ));

  static TextStyle body2Num = GoogleFonts.lato(
      textStyle: const TextStyle(
    fontFamily: 'Lato',
    fontWeight: FontWeight.w300,
    fontSize: 16,
  ));

  static TextStyle buttonTextNum = GoogleFonts.lato(
      textStyle: const TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 18,
  ));

  static TextStyle captionTextNum = GoogleFonts.lato(
      textStyle: const TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 14,
  ));

  static TextStyle overlineTextNum = GoogleFonts.lato(
      textStyle: const TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 12,
  ));
}
