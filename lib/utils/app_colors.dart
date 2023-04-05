import 'package:cdb_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;


class AppColors {
  /// Colors
  static const Color primaryBackgroundColor = Color(0xFF0977B2);
  static const Color primaryColor = Color(0xFF0078BF);
  static const Color accentColor = Color(0xFFFF473A);
  static const Color grayColor = Color(0xFF5D5D5D);
  static const Color lightBlueColor = Color(0xFFEEF7FF);
  static const Color textDarkColor = Color(0xFF0E1923);
  static const Color textLightColor = Color(0xFFA5A5A5);
  static const Color dividerColor = Color(0xFFD7D7D7);
  static const Color separationLinesColor = Color(0xFFEFEFEF);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color textTitleColor = Color(0xFF555454);
  static const Color lightAshColor = Color(0xFFE7E7E7);
  static const Color darkAshColor = Color(0xFFCDCDCD);
  static const Color errorRedColor = Color(0xFFFF2212);
  static const Color successGreenColor = Color(0xFF1EBB70);
  static const Color blackColor = Colors.black;
  static const Color textFieldBottomBorderEnabled = Color(0xFFE2E7ED);
  static const Color whiteDark = Color(0xFFF2F2F2);
  static const Color darkGray = Color(0xFF3A3B3E);
  static const Color greyWhiteColor = Color(0xFFF8F8F8);
  static const Color qrTorchColor = Color(0xFF6C6C6C);
  static const Color disableGray = Color(0x66555454);

  /// Gradients
  static const LinearGradient outlineGradient = LinearGradient(colors: [Color(0xFFFF6B17), Color(0xFFFF473A)]);
  static const LinearGradient fabGradient = LinearGradient(colors: [Color(0xFFFF6B17), Color(0xFFFF473A)],  stops: [0, 1], begin: Alignment.topCenter, end: Alignment.bottomCenter);
  static const LinearGradient sideButtonGradient = LinearGradient(colors: [Color(0xFFFF6B17), Color(0xFFFF473A)],  stops: [0, 1], begin: Alignment.centerRight, end: Alignment.centerLeft);
  static const LinearGradient greyGradient = LinearGradient(colors: [Color(0xFFA5A5A5), Color(0xFFA5A5A5)]);
  static const LinearGradient greenGradient = LinearGradient(colors: [Color(0xff2DD485), Color(0xff1CAB67)], stops: [0, 1], begin: Alignment.topCenter, end: Alignment.bottomCenter);
  static const LinearGradient blueGradient =
      LinearGradient(colors: [Color(0xff036EAD), Color(0xff3F9EF6), Color(0xff4481EB), Color(0xff2993D1)], stops: [0, 1, 1, 1], begin: Alignment.bottomLeft, end: Alignment.topRight);
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF2076C6), Color(0xFF2D84C5)],
    stops: [0, 0.36],
  );
  static const LinearGradient pinkGradient = LinearGradient(colors: [Color.fromRGBO(255, 255, 255, 0.75),
    Color.fromRGBO(255, 235, 235, 0.75), Color.fromRGBO(243, 243, 243, 0),], begin: Alignment.topCenter, end: Alignment.bottomCenter,);

  static const LinearGradient redGradient = LinearGradient(colors: [Color.fromRGBO(255, 255, 255, 0.75), Color.fromRGBO(255, 235, 235, 0.75), Color.fromRGBO(243, 243, 243, 0),], begin: Alignment.topCenter, end: Alignment.bottomCenter,);
}

class AppColorsWithOpacity {
  /// Colors
  final Color accentColorWithOpacity = const Color(0xFFFF473A).withOpacity(kAppOpacity);
  final Color textDarkColorWithOpacity = const Color(0xFF0E1923).withOpacity(kAppOpacity);

  /// Gradients
  final LinearGradient outlineGradientWithOpacity = LinearGradient(colors: [const Color(0xFFFF6B17).withOpacity(kAppOpacity), const Color(0xFFFF473A).withOpacity(kAppOpacity)]);
  final RadialGradient preLoginGradient = RadialGradient(colors: [const Color(0xFFFFFFA3).withOpacity(0.64), const Color(0xF3F3F324).withOpacity(0.14), const Color(0xC0C0C05C).withOpacity(0.36)], transform: const GradientRotation(math.pi / 2),  radius: 1,
    stops: const [
      0.178706,
      0.426676,
      0.678907,
    ],);
  final LinearGradient bannerGradientWithOpacity = const LinearGradient(colors: [ Color(0x5CFFD5D2),  Color(0x00FFFFFF), Color(0x0AFFFFFF),Color(0xFFFFFFFF)],begin: Alignment.topCenter, end: Alignment.bottomCenter,  stops: [0.1, 0.42, 0.78, 0.91]);
  final RadialGradient quickAccessGradient = RadialGradient(colors: [const Color(0xFFFFFFA3).withOpacity(0.64), const Color(0x24F3F3F3).withOpacity(0.14), const Color(0x5CC0C0C0).withOpacity(0.36)], transform: const GradientRotation(math.pi / 2),  radius: 1,
    );


  /// Getters
  Color get getAccentColorWithOpacity => accentColorWithOpacity;

  LinearGradient get getOutlineGradientWithOpacity => outlineGradientWithOpacity;
}
