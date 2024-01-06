import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_project/data/information.dart';
import 'package:new_project/models/class.dart';
import 'package:new_project/screens/quizList/createClassScreen.dart';
import 'package:new_project/data/classes.dart';
import 'package:new_project/screens/quizList/quizListScreen.dart';
import 'package:new_project/utils/app_styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class SelectClassScreen extends StatefulWidget {
  const SelectClassScreen({super.key, required this.setScreen});
  final void Function(Widget screen) setScreen;
  @override
  State<StatefulWidget> createState() {
    return _SelectClassScreen();
  }
}

class _SelectClassScreen extends State<SelectClassScreen> {
  List<Class>? userClasses;

  void addClass(Class newClass) {
    setState(() {
      classes.add(newClass);
    });
  }

  Future<void> getClasses() async {
    final response = await http.get(Uri.parse(url + '/api/class'));
    final parsedData = jsonDecode(response.body);
    List<dynamic> newData = parsedData['class'];
    setState(() {
      userClasses = newData
          .map(
            (e) => Class(
              classID: e['classID'],
              teacherID: e['teacherName'],
              className: e['className'],
            ),
          )
          .toList()
          .where((element) => userinfor.userClasses.contains(element.classID))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    if (userClasses == null) {
      getClasses();
    }
    return Expanded(
      child: Column(
        children: [
          Container(
            width: width,
            height: height - 100,
            child: ListView(
              children: [
                if (userClasses != null)
                  for (var lop in userClasses!)
                    TextButton(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${lop.classID} - ${lop.className}',
                              style: const TextStyle(
                                  fontSize: 20, color: AppThemes.headingColor),
                            ),
                            Text('Teacher: ${lop.teacherID}'),
                          ],
                        ),
                      ),
                      onPressed: () {
                        widget.setScreen(QuizListScreen(
                          selectedClass: lop,
                          setScreen: widget.setScreen,
                        ));
                      },
                    )
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (userinfor.isTeacher)
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      useSafeArea: true,
                      isScrollControlled: true,
                      context: context,
                      builder: (ctx) => CreateClassScreen(
                        addClass: addClass,
                        getClasses: getClasses,
                      ),
                    );
                  },
                  child: Text('Create Class',
                      style: Theme.of(context).textTheme.titleLarge),
                ),
            ],
          )
        ],
      ),
    );
  }
}
