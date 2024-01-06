import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_project/data/information.dart';
import 'package:new_project/screens/setting/information_change_screen.dart';
import 'package:new_project/screens/setting/password_change_screen.dart';
import 'package:new_project/screens/startScreen/start_screen.dart';
import 'package:new_project/utils/app_styles.dart';
import 'package:new_project/utils/functions.dart';
import 'package:new_project/utils/widgets.dart';
import 'package:http/http.dart' as http;

class SettingPage extends StatelessWidget {
  SettingPage({super.key, required this.setScreen});
  final void Function(Widget screen) setScreen;

  int rStatus = 0;
  String rMessage = '';

  Future<void> deleteAccount() async {
    final response = await http
        .post(Uri.parse(url + '/api/deleteAccount/' + userinfor.userName),
            body: json.encode({}))
        .then((value) => value);

    var response_data = jsonDecode(response.body);
    rMessage = response_data['message'];
    rStatus = response_data['status'];
  }

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
            avatar(screenWidth, screenHeight),
            Container(
              padding: EdgeInsets.only(bottom: screenHeight / 70),
              child: settingButton(() {
                setScreen(InformationChangeScreen(setScreen: setScreen));
              }, 'Account Setting', screenHeight, screenWidth),
            ),
            Container(
              padding: EdgeInsets.only(bottom: screenHeight / 70),
              child: settingButton(() {
                deleteAccount().then((value) {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text(
                        rStatus == 1 ? 'Successfully' : 'Error',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      content: Text(rMessage),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(ctx);
                            if (rStatus == 1) {
                              navigateToPage(context, const StartScreen());
                            }
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                });
              }, 'Delete Account', screenHeight, screenWidth),
            ),
            Container(
              padding: EdgeInsets.only(bottom: screenHeight / 70),
              child: settingButton(() {
                setScreen(PasswordChangeScreen(setScreen: setScreen));
              }, 'Change Password', screenHeight, screenWidth),
            ),
          ],
        ),
      ),
    );
  }
}
