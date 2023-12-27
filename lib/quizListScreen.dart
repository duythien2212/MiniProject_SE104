import 'package:flutter/material.dart';
import 'package:new_project/data/classes.dart';
import 'package:new_project/utils/app_styles.dart';

class QuizListScreen extends StatelessWidget {
  const QuizListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          for (var lop in classes)
            TextButton(
              child: Container(
                padding: EdgeInsets.all(16),
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => QuestionScreen(),
                  ),
                );
              },
            )
        ],
      ),
    );
  }
}

Widget QuestionScreen() {
  return Text("QuestionScreen");
}
