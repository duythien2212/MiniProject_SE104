import 'package:flutter/material.dart';
import 'package:new_project/utils/app_styles.dart';

Widget bigLogo(double screenWidth, double screenHeight) {
  return ClipRect(
    child: Image.asset(
      'assets/images/logo.jpg',
      width: screenWidth / 3,
      height: screenWidth / 3,
      fit: BoxFit.cover,
    ),
  );
}

Widget avatar(double screenWidth, double screenHeight) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: screenHeight / 20),
    child: ClipOval(
      child: Image.asset(
        'assets/images/avatar.png',
        width: screenWidth / 4,
        height: screenWidth / 4,
        fit: BoxFit.cover,
      ),
    ),
  );
}

ElevatedButton homeButton(Function()? onPressed, String title,
    double screenHeight, double screenWidth) {
  return ElevatedButton(
    onPressed: onPressed,
    style: homeButtonStyle(screenHeight, screenWidth),
    child: Text(title),
  );
}

ElevatedButton settingButton(Function()? onPressed, String title,
    double screenHeight, double screenWidth) {
  return ElevatedButton(
    onPressed: onPressed,
    style: settingButtonStyle(screenHeight, screenWidth),
    child: Text(title),
  );
}

ElevatedButton logoutMainButton(Function()? onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
      backgroundColor: AppThemes.barLogoutButtonColor,
      foregroundColor: AppThemes.barLogoutButtonTitleColor,
    ),
    child: const Text("LOGOUT"),
  );
}

String appName = 'App Name';
String logoPath = 'assets/images/logo_appbar.jpg';
