import 'package:flutter/material.dart';
import 'package:new_project/data/quizList.dart';
import 'package:new_project/models/quiz.dart';
import 'package:new_project/preStartQuizScreen.dart';
import 'package:new_project/utils/app_styles.dart';

class QuizListScreen extends StatelessWidget {
  const QuizListScreen({
    super.key,
    required this.classID,
    required this.className,
    required this.setScreen,
  });
  final String classID, className;
  final void Function(Widget screen) setScreen;

  @override
  Widget build(BuildContext context) {
    List<Quiz> classQuiz =
        quizList.where((quiz) => quiz.classID == classID).toList();
    return Column(
      children: [
        Text(
          classID + ' - ' + className,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Expanded(
          child: ListView(
            children: [
              for (var quiz in classQuiz)
                TextButton(
                  onPressed: () {
                    setScreen(PreStartQuizScreen(selectedQuiz: quiz));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          quiz.quizName,
                          style: const TextStyle(
                              fontSize: 20, color: AppThemes.headingColor),
                        ),
                        Text('Length: ${quiz.length} minute'),
                        Text('Deadline: ${quiz.endTime}'),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
