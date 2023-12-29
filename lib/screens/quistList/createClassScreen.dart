import 'package:flutter/material.dart';
import 'package:new_project/utils/custom_text_field.dart';
import 'package:new_project/utils/widgets.dart';

class CreateClassScreen extends StatefulWidget {
  const CreateClassScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _CreateClassScreenState();
  }
}

class _CreateClassScreenState extends State<CreateClassScreen> {
  var nStudent = 5;
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController studentIDController = TextEditingController();

  @override
  void dispose() {
    idController.dispose();
    nameController.dispose();
    studentIDController.dispose();
    return super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text('Create Class', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 30),
            customTextField(controller: idController, text: 'Enter class ID', screenWidth: screenWidth, screenHeight: screenHeight),
            customTextField(controller: nameController, text: 'Enter class name', screenWidth: screenWidth, screenHeight: screenHeight),
            for (int i = 0; i < nStudent; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customTextField(controller: studentIDController, text: 'Student ID', screenWidth: screenWidth, screenHeight: screenHeight),
                  IconButton.filledTonal(
                      onPressed: () {
                        setState(() {
                          nStudent--;
                        });
                      },
                      icon: Icon(Icons.remove))
                ],
              )
          ],
        ),
      ),
    );
  }
}
