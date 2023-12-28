import 'package:flutter/material.dart';
import 'package:new_project/data/classes.dart';
import 'package:new_project/quizListScreen.dart';
import 'package:new_project/utils/app_styles.dart';

class SelectClassScreen extends StatelessWidget {
  const SelectClassScreen({super.key, required this.setScreen});
  final void Function(Widget screen) setScreen;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          for (var lop in classes)
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
                      lop.classID + ' - ' + lop.className,
                      style: const TextStyle(
                          fontSize: 20, color: AppThemes.headingColor),
                    ),
                    Text('Teacher: ${lop.teacherID}'),
                  ],
                ),
              ),
              onPressed: () {
                setScreen(QuizListScreen(
                  selectedClass: lop,
                  setScreen: setScreen,
                ));
              },
            )
        ],
      ),
    );
  }
}
