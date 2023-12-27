import 'package:flutter/material.dart';
import 'package:new_project/utils/widgets.dart';

class PasswordChangeScreen extends StatelessWidget {
  const PasswordChangeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Change password",
          style: TextStyle(
            color: const Color.fromARGB(255, 15, 30, 114),
            fontSize: screenHeight / 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: screenHeight / 16),
        customTextField(screenWidth * 1.5, screenHeight, 'OLD PASSWORD'),
        customTextField(screenWidth * 1.5, screenHeight, 'NEW PASSWORD'),
        customTextField(screenWidth * 1.5, screenHeight, 'CONFIRM PASSWORD'),
        SizedBox(height: screenHeight / 20),
        settingButton(() => null, "CHANGE PASSWORD", screenHeight, screenWidth),
      ],
    );
  }
}
