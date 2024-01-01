import 'package:flutter/material.dart';
import 'package:new_project/screens/setting/setting_page.dart';
import 'package:new_project/utils/custom_text_field.dart';
import 'package:new_project/utils/widgets.dart';

class InformationChangeScreen extends StatefulWidget {
  const InformationChangeScreen({super.key, required this.setScreen});
  final void Function(Widget screen) setScreen;

  @override
  State<InformationChangeScreen> createState() => _InformationChangeScreenState();
}

class _InformationChangeScreenState extends State<InformationChangeScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    return super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final void Function(Widget screen) setScreen = widget.setScreen;
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

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
                "Account Setting",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
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
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text(
                          "Change avatar",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        content: Text(
                          "Up load your new avatar",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    );
                  },
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
        customTextField(controller: firstNameController, text: "Enter new first name", screenWidth: screenWidth * 1.2, screenHeight: screenHeight),
        customTextField(controller: lastnameController, text: "Enter new last name", screenWidth: screenWidth * 1.2, screenHeight: screenHeight),
        customTextField(controller: emailController, text: "Enter new email", screenWidth: screenWidth * 1.2, screenHeight: screenHeight),
        SizedBox(height: screenHeight / 60),
        settingButton(() {
          setScreen(SettingPage(setScreen: setScreen));
        }, 'Save', screenHeight, screenWidth / 1.5),
      ],
    );
  }
}
