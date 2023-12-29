import 'package:flutter/material.dart';
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
            customTextField(screenWidth, screenHeight, 'Enter class ID'),
            customTextField(screenWidth, screenHeight, 'Enter class name'),
            for (int i = 0; i < nStudent; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customTextField(screenWidth, screenHeight, 'Student ID'),
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
