import 'package:flutter/material.dart';
import 'package:new_project/utils/custom_text_field.dart';
import 'package:new_project/utils/widgets.dart';

class PasswordChangeScreen extends StatefulWidget {
  const PasswordChangeScreen({super.key});

  @override
  State<PasswordChangeScreen> createState() => _PasswordChangeScreenState();
}

class _PasswordChangeScreenState extends State<PasswordChangeScreen> {
  final TextEditingController oldController = TextEditingController();
  final TextEditingController newController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  @override
  void dispose() {
    oldController.dispose();
    newController.dispose();
    confirmController.dispose();
    return super.dispose();
  }

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
        customTextField(controller: oldController, text: 'OLD PASSWORD', screenWidth: screenWidth * 1.5, screenHeight: screenHeight),
        customTextField(controller: newController, text: 'NEW PASSWORD', screenWidth: screenWidth * 1.5, screenHeight: screenHeight),
        customTextField(controller: confirmController, text: 'CONFIRM PASSWORD', screenWidth: screenWidth * 1.5, screenHeight: screenHeight),
        SizedBox(height: screenHeight / 20),
        settingButton(() => null, "CHANGE PASSWORD", screenHeight, screenWidth),
      ],
    );
  }
}
