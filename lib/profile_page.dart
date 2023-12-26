import 'package:flutter/material.dart';
import 'package:new_project/utils/app_styles.dart';

Widget profilePage(double screenWidth, double screenHeight) {
  return Container(
    color: AppThemes.mainScreenBackroundColor,
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          avatar(screenWidth),
          SizedBox(height: screenHeight / 50),
          informationField('USER NAME', screenWidth, screenHeight),
          SizedBox(height: screenHeight / 50),
          informationField('NAME', screenWidth, screenHeight),
          SizedBox(height: screenHeight / 50),
          informationField('CLASS', screenWidth, screenHeight),
          SizedBox(height: screenHeight / 50),
          informationField('EMAIL', screenWidth, screenHeight),
        ],
      ),
    ),
  );
}

Widget avatar(double screenWidth) {
  return ClipOval(
    child: Image.asset(
      'assets/images/logo_test.png',
      width: screenWidth / 3,
      height: screenWidth / 3,
      fit: BoxFit.cover,
    ),
  );
}

Widget informationField(String text, double screenWidth, double screenHeight) {
  return Container(
    height: screenHeight / 30,
    width: screenWidth / 1.5,
    decoration: BoxDecoration(
      color: AppThemes.navigationRailBackroundColor,
      borderRadius: BorderRadius.circular(screenWidth / 20),
      border: Border.all(),
    ),
    child: Center(
      child: Text(
        text,
        style: TextStyle(fontSize: screenHeight / 60),
      ),
    ),
  );
}
