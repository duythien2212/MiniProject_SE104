import 'package:flutter/material.dart';
import 'package:new_project/data/information.dart';
import 'package:new_project/utils/widgets.dart';

class InformationChangeScreen extends StatelessWidget {
  const InformationChangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        avatar(screenWidth / 1.5),
        customTextField(screenWidth * 1.2, screenHeight, "Enter new first name"),
        customTextField(screenWidth * 1.2, screenHeight, "Enter new last name"),
        customTextField(screenWidth * 1.2, screenHeight, "Enter new email"),
        SizedBox(height: screenHeight / 30),
        settingButton(() => null, 'Save', screenHeight, screenWidth / 1.5),
      ],
    );
  }
}
