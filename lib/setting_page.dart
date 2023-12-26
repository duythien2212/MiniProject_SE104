import 'package:flutter/material.dart';
import 'package:new_project/utils/app_styles.dart';
import 'package:new_project/utils/widgets.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      color: AppThemes.mainScreenBackroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            avatar(screenWidth),
            Container(
              padding: EdgeInsets.only(bottom: screenHeight / 70),
              child: settingButton(() => null, 'Account Setting', screenHeight, screenWidth),
            ),
            Container(
              padding: EdgeInsets.only(bottom: screenHeight / 70),
              child: settingButton(() => null, 'Delete Account', screenHeight, screenWidth),
            ),
            Container(
              padding: EdgeInsets.only(bottom: screenHeight / 70),
              child: settingButton(() => null, 'Change Password', screenHeight, screenWidth),
            ),
            SizedBox(height: screenHeight / 50),
            Container(
              padding: EdgeInsets.only(bottom: screenHeight / 70),
              child: settingButton(() => null, 'Logout', screenHeight, screenWidth),
            ),
          ],
        ),
      ),
    );
  }
}
