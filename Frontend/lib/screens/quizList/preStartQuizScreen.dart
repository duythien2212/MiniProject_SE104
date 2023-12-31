import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_project/data/information.dart';
import 'package:new_project/models/class.dart';
import 'package:new_project/models/question.dart';
import 'package:new_project/models/quiz.dart';
import 'package:new_project/screens/quizList/quizListScreen.dart';
import 'package:new_project/screens/quizList/startQuizScreen.dart';
import 'package:new_project/utils/app_styles.dart';
import 'package:http/http.dart' as http;

class PreStartQuizScreen extends StatelessWidget {
  PreStartQuizScreen(
      {super.key,
      required this.selectedQuiz,
      required this.selectedClass,
      required this.setScreen});
  final Class selectedClass;
  final Quiz selectedQuiz;
  final void Function(Widget screen) setScreen;
  List<Question>? quizQuestions;

  Future<void> getQuestions(quizID) async {
    List<Question> questions;
    final response = await http
        .get(Uri.parse(url + '/api/getQuestionQuiz/' + quizID.toString()));
    final parsedData = jsonDecode(response.body);
    List<dynamic> newData = parsedData['message'];
    questions = newData.map((e) {
      List<String> listAnswer = [];
      int correctAnswer = -1;
      for (var i = 0; i < 4; i++) {
        listAnswer.add(e['listAnswer'][i].toString());
        if (e['correctAnswer'] == e['listAnswer'][i].toString()) {
          correctAnswer = i;
          print(e['correctAnswer']);
        }
      }
      return Question('', e['question'], listAnswer, correctAnswer);
    }).toList();
    quizQuestions = questions;
    selectedQuiz.questions = quizQuestions!;
  }

  @override
  Widget build(BuildContext context) {
    var bodyTheme = Theme.of(context).textTheme.bodyMedium;
    getQuestions(selectedQuiz.quizID);
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 30),
              IconButton(
                onPressed: () {
                  setScreen(QuizListScreen(
                      selectedClass: selectedClass, setScreen: setScreen));
                },
                icon: const Icon(Icons.arrow_back),
              )
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height - 100,
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
                Text('Length: ${selectedQuiz.length} minutes',
                    style: bodyTheme),
                Text('Weight: ${selectedQuiz.weight}', style: bodyTheme),
                Text('Start time: ${selectedQuiz.startTime}', style: bodyTheme),
                Text('Deadline: ${selectedQuiz.endTime}', style: bodyTheme),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppThemes.headingColor),
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
                      color: AppThemes.headingTextColor,
                    ),
                  ),
                ),
                if (userinfor.isTeacher)
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (userinfor.isTeacher)
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            'Download results',
                            style: TextStyle(
                              color: AppThemes.headingColor,
                              fontSize: 15,
                            ),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
