import 'package:flutter/material.dart';

class Constant {
  static Widget textWithStyle(
      {required String text,
      required double size,
      String? fontFamily,
      FontStyle? fontStyle,
      required Color color,
      FontWeight? fontWeight = FontWeight.w500,
      double? fontSpacing,
      int? maxLine,
      TextAlign? textAlign}) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLine,
      style: TextStyle(
        fontFamily: 'Nunito',
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: fontSpacing,
      ),
    );
  }

  static const Color textPrimary = Color.fromARGB(255, 252, 252, 252);
  static const Color textSecondary = Color.fromARGB(255, 32, 32, 32);
  static const Color bgPrimary = Color.fromARGB(255, 255, 255, 255);
  static const Color bgSecondaryGreen = Color(0xFF008F15);
  static const Color bgOrange = Color.fromARGB(255, 255, 140, 0);
  static const Color bgRed = Color(0xFFBC3B3B);
  static const Color bgBlue = Color(0xFF008CFF);
}
