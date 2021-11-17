import 'package:flutter/material.dart';

class MyColor {
  static const MaterialColor primary = const MaterialColor(
    0xFF5C4FE1,
    <int, Color>{
      50: Color(0xFFEBEBFC),
      100: Color(0xFFCDCCF7),
      200: Color(0xFFACABF2),
      300: Color(0xFF8A89ED),
      400: Color(0xFF716CE8),
      500: Color(0xFF5C4FE1),
      600: Color(0xFF5646D5),
      700: Color(0xFF4D3AC9),
      800: Color(0xFF462EBD),
      900: Color(0xFF3A11AA),
    },
  );

  //text color
  static const Color primaryTextColor = const Color(0xFFFFFFFF);
  static const Color accentTextColor = const Color(0x99FFFFFF);

  static const Color pressed = const Color(0xFFEBEBFC);
  static const Color hover = const Color(0x0A5C4FE1);
  static const Color focused = const Color(0x334FE1);
  static const Color dragged = const Color(0x295C4FE1);

  static const Color black = const Color(0xFF000000);

  static const Color darkPrimary = const Color(0xFF000000);
  static const Color darkSub = const Color(0x33000000);
  static const Color darkSub2 = const Color(0xFF2B2B2B);
  static const Color darkSub3 = const Color(0xFF363636);
  static const Color darkContainer = const Color(0xFF222224);
  static const Color darkBottomSheet = const Color(0xFF161616);
  static const Color outLine = const Color(0x1F000000);
  static const Color white = const Color(0xFFFFFFFF);
  static const Color whiteSub = const Color(0xFF7A7A7C);
  static const Color whiteSub2 = const Color(0x66FFFFFF);
  static const Color whiteSub3 = const Color(0x26FFFFFF);
}