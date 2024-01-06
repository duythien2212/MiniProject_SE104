import 'package:flutter/material.dart';
import 'package:new_project/screens/startScreen/login_screen.dart';
import 'package:new_project/screens/startScreen/register_screen.dart';
import 'package:new_project/utils/functions.dart';
import 'package:new_project/utils/custom_app_bar.dart';
import 'package:new_project/utils/app_styles.dart';
import 'package:new_project/utils/widgets.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const StartScreenAppBar(titles: "WELCOME TO,..."),
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
                  homeButton(() {
                    navigateToPage(context, const LoginScreen());
                  }, 'LOGIN', screenHeight, screenWidth),
                  SizedBox(
                    height: screenHeight / 20,
                  ),
                  homeButton(() {
                    navigateToPage(context, const RegisterScreen());
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
