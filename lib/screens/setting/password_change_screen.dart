import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_project/data/information.dart';
import 'package:new_project/screens/setting/setting_page.dart';
import 'package:new_project/utils/custom_text_field.dart';
import 'package:new_project/utils/widgets.dart';
import 'package:http/http.dart' as http;

class PasswordChangeScreen extends StatefulWidget {
  const PasswordChangeScreen({super.key, required this.setScreen});
  final void Function(Widget screen) setScreen;

  @override
  State<PasswordChangeScreen> createState() => _PasswordChangeScreenState();
}

class _PasswordChangeScreenState extends State<PasswordChangeScreen> {
  final TextEditingController oldController = TextEditingController();
  final TextEditingController newController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  String rMessage = '';
  int rStatus = 0;
  Future<void> changePassword() async {
    final response = await http.post(
        Uri.parse(url + '/api/updatePassword/' + userinfor.userName),
        body: json.encode({
          'oldPassword': oldController.text,
          'newPassword': newController.text,
          'cPassword': confirmController.text,
        }));
    var r_data = jsonDecode(response.body);
    rMessage = r_data['message'];
    rStatus = r_data['status'];
  }

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
    final void Function(Widget screen) setScreen = widget.setScreen;

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: 50,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  setScreen(SettingPage(setScreen: setScreen));
                },
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(width: 10),
              Text(
                "Change Password",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight / 6),
        Text(
          "Change password",
          style: TextStyle(
            color: const Color.fromARGB(255, 15, 30, 114),
            fontSize: screenHeight / 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: screenHeight / 20),
        customTextField(
            controller: oldController,
            text: 'Old password',
            screenWidth: screenWidth * 1.2,
            screenHeight: screenHeight * 0.8),
        customTextField(
            controller: newController,
            text: 'New password',
            screenWidth: screenWidth * 1.2,
            screenHeight: screenHeight * 0.8),
        customTextField(
            controller: confirmController,
            text: 'Confirm password',
            screenWidth: screenWidth * 1.2,
            screenHeight: screenHeight * 0.8),
        SizedBox(height: screenHeight / 20),
        settingButton(
          () {
            changePassword().then((value) {
              if (rStatus == 1) {
                setScreen(SettingPage(setScreen: setScreen));
              } else {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("Error",
                        style: Theme.of(context).textTheme.titleLarge),
                    content: Text(rMessage),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            });
          },
          "CHANGE PASSWORD",
          screenHeight * 0.8,
          screenWidth * 0.8,
        ),
      ],
    );
  }
}
