import 'package:flutter/material.dart';
import 'package:new_project/addQuizScreen.dart';
import 'package:new_project/data/information.dart';
import 'package:new_project/data/quizList.dart';
import 'package:new_project/models/class.dart';
import 'package:new_project/models/quiz.dart';
import 'package:new_project/preStartQuizScreen.dart';
import 'package:new_project/selectClassScreen.dart';
import 'package:new_project/utils/app_styles.dart';

class QuizListScreen extends StatelessWidget {
  const QuizListScreen({
    super.key,
    required this.selectedClass,
    required this.setScreen,
  });
  final Class selectedClass;
  final void Function(Widget screen) setScreen;

  @override
  Widget build(BuildContext context) {
    List<Quiz> classQuiz = quizList
        .where((quiz) => quiz.classID == selectedClass.classID)
        .toList();
    return Column(
      children: [
        Container(
          height: 50,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  setScreen(SelectClassScreen(setScreen: setScreen));
                },
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(width: 10),
              Text(
                selectedClass.classID + ' - ' + selectedClass.className,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 150,
          padding: const EdgeInsets.only(bottom: 20),
          child: Expanded(
            child: ListView(
              children: [
                for (var quiz in classQuiz)
                  TextButton(
                    onPressed: () {
                      setScreen(PreStartQuizScreen(
                        selectedQuiz: quiz,
                        selectedClass: selectedClass,
                        setScreen: setScreen,
                      ));
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
                          Text('Weight: ${quiz.weight}'),
                          Text('Notifications: ${quiz.notification}'),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (userinfor.isTeacher)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppThemes.headingColor),
                onPressed: () {
                  showModalBottomSheet(
                    useSafeArea: true,
                    isScrollControlled: true,
                    context: context,
                    builder: (ctx) => AddQuizScreen(),
                  );
                },
                child: const Icon(
                  Icons.add,
                  color: AppThemes.headingTextColor,
                ),
              )
          ],
        ),
      ],
    );
  }
}
