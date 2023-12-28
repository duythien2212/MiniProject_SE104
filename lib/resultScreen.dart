import 'package:flutter/material.dart';
import 'package:new_project/models/quiz.dart';
import 'package:new_project/utils/app_styles.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.quiz,
    required this.selectedAnswer,
  });

  final Quiz quiz;
  final List<int> selectedAnswer;

  @override
  Widget build(BuildContext context) {
    var nCorrect = 0;
    var nQuestion = quiz.questions.length;

    for (int i = 0; i < nQuestion; i++) {
      if (quiz.questions[i].correctAnswer == selectedAnswer[i]) {
        nCorrect++;
      }
    }
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            quiz.quizName,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 30),
          Text(
            'Number of correct answers: ${nCorrect}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          Text(
            'Number of questions: ${nQuestion}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          Text(
            'Score: ' + (nCorrect * 10 / nQuestion).toStringAsFixed(2),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 100),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: AppThemes.headingColor),
            child: const Text(
              'Finish',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
