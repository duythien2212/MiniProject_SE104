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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    return super.dispose();
  }

  String responseMessage = '';
  int responseStatus = 0;

  Future<void> _register() async {
    final response = await http
        .post(Uri.parse(url + '/api/register'),
            body: json.encode({
              'lastname': lastNameController.text,
              'firstname': firstNameController.text,
              'email': emailController.text,
              'username': usernameController.text,
              'password': passwordController.text,
              'cPassword': confirmController.text,
            }))
        .then((value) => value);

    var response_data = jsonDecode(response.body);
    responseMessage = response_data['message'];
    responseStatus = response_data['status'];
  }

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
                      customTextField(
                          controller: firstNameController,
                          text: "First name",
                          screenWidth: (screenWidth - 20) / 2,
                          screenHeight: screenHeight),
                      const SizedBox(width: 10),
                      customTextField(
                          controller: lastNameController,
                          text: "Last name",
                          screenWidth: (screenWidth - 20) / 2,
                          screenHeight: screenHeight),
                    ],
                  ),
                  customTextField(
                      controller: emailController,
                      text: 'Enter email',
                      screenWidth: screenWidth,
                      screenHeight: screenHeight),
                  customTextField(
                      controller: usernameController,
                      text: 'Enter username',
                      screenWidth: screenWidth,
                      screenHeight: screenHeight),
                  customTextField(
                      controller: passwordController,
                      text: 'Enter password',
                      screenWidth: screenWidth,
                      screenHeight: screenHeight),
                  customTextField(
                      controller: confirmController,
                      text: 'Confirm password',
                      screenWidth: screenWidth,
                      screenHeight: screenHeight),
                  const SizedBox(height: 10),
                  homeButton(
                    () {
                      _register().then((value) {
                        if (responseStatus == 1) {
                          navigateToPage(context, const MainScreen());
                        } else {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text(
                                'Error',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              content: Text(
                                responseMessage,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(ctx);
                                  },
                                  child: const Text('Ok'),
                                ),
                              ],
                            ),
                          );
                        }
                      });
                    },
                    'REGISTER',
                    screenHeight,
                    screenWidth,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
