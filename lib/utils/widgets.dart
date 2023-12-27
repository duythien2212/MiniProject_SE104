import 'package:flutter/material.dart';
import 'package:new_project/utils/app_styles.dart';

Widget bigLogo(double screenWidth, double screenHeight) {
  return ClipOval(
    child: Image.asset(
      'assets/images/logo_test.png',
      width: screenWidth / 3,
      height: screenWidth / 3,
      fit: BoxFit.cover,
    ),
  );
}

Widget avatar(double screenWidth) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 40),
    child: ClipOval(
      child: Image.asset(
        'assets/images/avatar.jpg',
        width: screenWidth / 4,
        height: screenWidth / 4,
        fit: BoxFit.cover,
      ),
    ),
  );
}

ElevatedButton homeButton(Function()? onPressed, String title, double screenHeight, double screenWidth) {
  return ElevatedButton(
    onPressed: onPressed,
    style: homeButtonStyle(screenHeight, screenWidth),
    child: Text(title),
  );
}

ElevatedButton settingButton(Function()? onPressed, String title, double screenHeight, double screenWidth) {
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

Widget customTextField(double screenWidth, double screenHeight, String text) {
  return SizedBox(
    width: screenWidth / 5,
    height: screenHeight / 11,
    child: TextField(
      decoration: InputDecoration(
        hintText: text,
      ),
    ),
  );
}

String appName = 'App Name';
String logoPath = 'assets/images/logo_test.png';
