import 'package:flutter/material.dart';
import 'package:new_project/main_screen.dart';
import 'package:new_project/utils/app_styles.dart';
import 'package:new_project/utils/functions.dart';
import 'package:new_project/utils/custom_app_bar.dart';
import 'package:new_project/utils/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const StartScreenAppBar(titles: "REGISTER"),
      backgroundColor: AppThemes.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              bigLogo(screenWidth, screenHeight),
              Column(
                children: [
                  Row(
                    children: [
                      customTextField((screenWidth - 20) / 2, screenHeight, 'First name'),
                      const SizedBox(width: 10),
                      customTextField((screenWidth - 20) / 2, screenHeight, 'Last name'),
                    ],
                  ),
                  customTextField(screenWidth, screenHeight, 'Enter email'),
                  customTextField(screenWidth, screenHeight, 'Enter username'),
                  customTextField(screenWidth, screenHeight, 'Enter password'),
                  customTextField(screenWidth, screenHeight, 'Confirm password'),
                  const SizedBox(height: 10),
                  homeButton(() {
                    navigateToPage(context, const MainScreen());
                  }, 'REGISTER', screenHeight, screenWidth),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
