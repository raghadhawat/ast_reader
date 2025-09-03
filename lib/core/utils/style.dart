import 'package:flutter/material.dart';

abstract class AppStyles {
  // Arial Regular  → using Arimo (bundled in your pubspec)
  static TextStyle arialRegular(BuildContext context, double base) {
    return TextStyle(
      fontSize: getResponsiveFontSize(baseFontSize: base, context: context),
      fontFamily: 'Arimo', // using Arimo to represent Arial Regular
      fontWeight: FontWeight.w400,
    );
  }

  // Arial Bold  → using Arimo Bold
  static TextStyle arialBold(BuildContext context, double base) {
    return TextStyle(
      fontSize: getResponsiveFontSize(baseFontSize: base, context: context),
      fontFamily: 'Arimo',
      fontWeight: FontWeight.w700,
    );
  }

  // Source Sans Pro Bold  → requires adding Source Sans Pro font to pubspec
  static TextStyle sourceSansProBold(BuildContext context, double base) {
    return TextStyle(
      fontSize: getResponsiveFontSize(baseFontSize: base, context: context),
      fontFamily: 'Arimo', // add this family to pubspec if you want it
      fontWeight: FontWeight.w700,
    );
  }

  // ---------- SPECIFIC STYLES FROM YOUR FILE ----------
  // "regular 13"  → Regular weight, size 13
  static TextStyle styleRegular13(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(baseFontSize: 13, context: context),
      fontFamily: 'Arimo',
      fontWeight: FontWeight.w400,
    );
  }

  // "17 reg"  → Regular weight, size 17
  static TextStyle styleRegular17(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(baseFontSize: 17, context: context),
      fontFamily: 'Arimo',
      fontWeight: FontWeight.w400,
    );
  }
}

double getResponsiveFontSize(
    {required double baseFontSize, required BuildContext context}) {

  return baseFontSize; // 375 is an example base width
}
