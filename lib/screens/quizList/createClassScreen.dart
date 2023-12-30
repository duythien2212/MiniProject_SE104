import 'package:flutter/material.dart';
import 'package:new_project/data/classes.dart';
import 'package:new_project/data/information.dart';
import 'package:new_project/models/class.dart';
import 'package:new_project/utils/custom_text_field.dart';
import 'package:new_project/utils/widgets.dart';

class CreateClassScreen extends StatefulWidget {
  const CreateClassScreen({super.key, required this.addClass});
  final void Function(Class newClass) addClass;
  @override
  State<StatefulWidget> createState() {
    return _CreateClassScreenState();
  }
}

class _CreateClassScreenState extends State<CreateClassScreen> {
  var nStudent = 0;
  String classID = '', className = '';
  List<String> studentIDs = [];
  @override
  Widget build(BuildContext context) {
    while (studentIDs.length < nStudent) {
      studentIDs.add('');
    }
    while (studentIDs.length > nStudent) {
      studentIDs.removeLast();
    }
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text('Create Class', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 30),
            TextInput(
              name: 'Class ID',
              onChange: (input) {
                classID = input;
              },
            ).createTextField(),
            TextInput(
              name: 'Class name',
              onChange: (input) {
                className = input;
              },
            ).createTextField(),
            TextInput(
              name: 'Number of students',
              onChange: (input) {
                setState(() {
                  nStudent = int.parse(input);
                });
              },
            ).createTextField(),
            const SizedBox(height: 20),
            if (nStudent > 0) const Text('Students'),
            for (int i = 0; i < nStudent; i++)
              TextInput(
                name: 'Student ID',
                onChange: (input) {
                  studentIDs[i] = input;
                },
              ).createTextField(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.addClass(Class(
                        classID: classID,
                        teacherID: userinfor.userID,
                        className: className));
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
