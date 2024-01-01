import 'dart:async';
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
  int responseStatus = 0;
  String responseMessage = 'Chưa nhập username và mật khẩu!';

  Future<void> _login() async {
    final response = await http
        .post(Uri.parse(url + '/api/login'),
            body: json.encode({
              'username': usernameController.text,
              'password': passwordController.text,
            }))
        .then((value) => value);
    var response_data = jsonDecode(response.body);
    responseMessage = response_data['message'];
    responseStatus = response_data['status'];
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
                    _login().then((value) {
                      if ((responseStatus) == 1) {
                        loginInput = loginInformation(
                            usernameController.text, passwordController.text);
                        getInformation(usernameController.text);
                        navigateToPage(context, const MainScreen());
                      } else {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text(
                              'Error',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            content: Text(responseMessage),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    });
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
