import 'package:flutter/material.dart';
import 'package:new_project/data/information.dart';
import 'package:new_project/utils/app_styles.dart';
import 'package:new_project/utils/widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      color: AppThemes.mainScreenBackroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            avatar(screenWidth, screenHeight),
            informationField(userinfor.userName, screenWidth, screenHeight),
            informationField('${userinfor.lastName} ${userinfor.firstName}',
                screenWidth, screenHeight),
            informationField(userinfor.isTeacher ? 'Teacher' : 'Student',
                screenWidth, screenHeight),
            informationField(userinfor.email, screenWidth, screenHeight),
          ],
        ),
      ),
    );
  }
}

Widget informationField(String text, double screenWidth, double screenHeight) {
  return Padding(
    padding: EdgeInsets.only(top: screenHeight / 50),
    child: Container(
      height: screenHeight / 20,
      width: screenWidth / 3,
      decoration: BoxDecoration(
        color: AppThemes.navigationRailBackroundColor,
        borderRadius: BorderRadius.circular(screenWidth / 20),
        border: Border.all(),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontSize: screenHeight / 40, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
