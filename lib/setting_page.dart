import 'package:flutter/material.dart';
import 'package:new_project/delete_account_screen.dart';
import 'package:new_project/information_change_screen.dart';
import 'package:new_project/password_change_screen.dart';
import 'package:new_project/utils/app_styles.dart';
import 'package:new_project/utils/widgets.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key, required this.setScreen});
  final void Function(Widget screen) setScreen;
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
              child: settingButton(() {
                setScreen(const InformationChangeScreen());
              }, 'Account Setting', screenHeight, screenWidth),
            ),
            Container(
              padding: EdgeInsets.only(bottom: screenHeight / 70),
              child: settingButton(() {
                setScreen(const DeleteAccountScreen());
              }, 'Delete Account', screenHeight, screenWidth),
            ),
            Container(
              padding: EdgeInsets.only(bottom: screenHeight / 70),
              child: settingButton(() {
                setScreen(const PasswordChangeScreen());
              }, 'Change Password', screenHeight, screenWidth),
            ),
          ],
        ),
      ),
    );
  }
}
