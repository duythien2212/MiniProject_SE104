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
        Stack(
          children: [
            avatar(screenWidth / 1.5, screenHeight / 1.5),
            Padding(
              padding: EdgeInsets.only(top: screenHeight / 30 + screenWidth / 165, left: screenWidth / 165),
              child: Container(
                height: screenHeight / 15,
                width: screenHeight / 15,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(190, 255, 255, 255),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton.outlined(
                  color: const Color.fromARGB(171, 0, 0, 0),
                  onPressed: () {},
                  icon: Icon(
                    Icons.add_a_photo,
                    size: screenHeight / 30,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: screenHeight / 60),
        customTextField(screenWidth * 1.2, screenHeight, "Enter new first name"),
        customTextField(screenWidth * 1.2, screenHeight, "Enter new last name"),
        customTextField(screenWidth * 1.2, screenHeight, "Enter new email"),
        SizedBox(height: screenHeight / 60),
        settingButton(() => null, 'Save', screenHeight, screenWidth / 1.5),
      ],
    );
  }
}
