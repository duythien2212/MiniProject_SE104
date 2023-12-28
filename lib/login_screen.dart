import 'package:flutter/material.dart';
import 'package:new_project/data/information.dart';
import 'package:new_project/main_screen.dart';
import 'package:new_project/utils/app_styles.dart';
import 'package:new_project/utils/custom_text_field.dart';
import 'package:new_project/utils/functions.dart';
import 'package:new_project/utils/custom_app_bar.dart';
import 'package:new_project/utils/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const StartScreenAppBar(titles: "LOGIN"),
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
                  customTextField(screenWidth: screenWidth, screenHeight: screenHeight, text: "Enter username", controller: usernameController),
                  customTextField(screenWidth: screenWidth, screenHeight: screenHeight, text: "Enter password", controller: passwordController),
                  const SizedBox(height: 10),
                  homeButton(() {
                    loginInput = loginInformation(usernameController.text, passwordController.text);
                    navigateToPage(context, const MainScreen());
                  }, 'LOGIN', screenHeight, screenWidth),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
