import 'package:flutter/material.dart';

class AppThemes {
  static const Color backgroundColor = Color.fromARGB(31, 164, 235, 238);
  static const Color headingColor = Color.fromRGBO(21, 72, 167, 0.984);
  static const Color headingTextColor = Colors.white;
  static const Color buttonColor = Color.fromRGBO(21, 72, 167, 0.984);
  static const Color buttonTitleColor = Colors.white;
  static const Color barLogoutButtonTitleColor = Colors.black;
  static const Color barLogoutButtonColor = Colors.white;
  static const Color navigationRailBackroundColor = Color.fromARGB(31, 74, 137, 139);
  static const Color mainScreenBackroundColor = Colors.white;
  static const Color mainButtonColor = Color.fromARGB(255, 52, 105, 197);
}

ButtonStyle homeButtonStyle(double screenHeight, double screenWidth) {
  return ElevatedButton.styleFrom(
    fixedSize: Size(screenWidth / 6, screenHeight / 10),
    textStyle: TextStyle(fontSize: screenHeight / 30),
    backgroundColor: AppThemes.buttonColor,
    foregroundColor: AppThemes.buttonTitleColor,
  );
}

ButtonStyle settingButtonStyle(double screenHeight, double screenWidth) {
  return ElevatedButton.styleFrom(
    fixedSize: Size(screenWidth / 3, screenHeight / 14),
    textStyle: TextStyle(fontSize: screenHeight / 30),
    backgroundColor: AppThemes.mainButtonColor,
    foregroundColor: AppThemes.buttonTitleColor,
  );
}
