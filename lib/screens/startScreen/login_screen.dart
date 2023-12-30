import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_project/data/information.dart';
import 'package:new_project/screens/startScreen/main_screen.dart';
import 'package:new_project/utils/app_styles.dart';
import 'package:new_project/utils/custom_text_field.dart';
import 'package:new_project/utils/functions.dart';
import 'package:new_project/utils/custom_app_bar.dart';
import 'package:new_project/utils/widgets.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final url = 'http://127.0.0.1:4000';

  Future<int> _login() async {
    final response = await http.post(Uri.parse(url + '/api/login'),
        body: json.encode({
          'username': usernameController.text,
          'password': passwordController.text
        }));
    var response_data = jsonDecode(response.body);
    print(response_data['message']);
    return int.parse(response_data['status']);
  }

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
                  customTextField(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      text: "Enter username",
                      controller: usernameController),
                  customTextField(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      text: "Enter password",
                      controller: passwordController),
                  const SizedBox(height: 10),
                  homeButton(() {
                    var status = _login();
                    if ((status) == 1) {
                      loginInput = loginInformation(
                          usernameController.text, passwordController.text);
                      navigateToPage(context, const MainScreen());
                    } else {}
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
