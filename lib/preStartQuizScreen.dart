import 'package:flutter/material.dart';
import 'package:new_project/models/quiz.dart';
import 'package:new_project/startQuizScreen.dart';
import 'package:new_project/utils/app_styles.dart';

class PreStartQuizScreen extends StatelessWidget {
  const PreStartQuizScreen({super.key, required this.selectedQuiz});
  final Quiz selectedQuiz;
  @override
  Widget build(BuildContext context) {
    var bodyTheme = Theme.of(context).textTheme.bodyMedium;
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              selectedQuiz.quizName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            Text('Length: ${selectedQuiz.length} minutes', style: bodyTheme),
            Text('Deadline: ${selectedQuiz.endTime}', style: bodyTheme),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) =>
                        StartQuizScreen(selectedQuiz: selectedQuiz),
                  ),
                );
              },
              child: const Text(
                'Start',
                style: TextStyle(
                  fontSize: 20,
                  color: AppThemes.headingColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
