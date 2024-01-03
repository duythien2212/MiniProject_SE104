import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_project/models/question.dart';
import 'package:new_project/screens/quizList/addQuizScreen.dart';
import 'package:new_project/data/information.dart';
import 'package:new_project/data/quizList.dart';
import 'package:new_project/models/class.dart';
import 'package:new_project/models/quiz.dart';
import 'package:new_project/screens/quizList/preStartQuizScreen.dart';
import 'package:new_project/screens/quizList/selectClassScreen.dart';
import 'package:new_project/utils/app_styles.dart';
import 'package:http/http.dart' as http;

// can sua

class QuizListScreen extends StatefulWidget {
  const QuizListScreen({
    super.key,
    required this.selectedClass,
    required this.setScreen,
  });
  final Class selectedClass;
  final void Function(Widget screen) setScreen;
  @override
  State<StatefulWidget> createState() {
    return _QuizListScreenState();
  }
}

class _QuizListScreenState extends State<QuizListScreen> {
  List<Quiz>? classQuiz;

  Future<void> getQuiz() async {
    String classID = widget.selectedClass.classID;
    final response =
        await http.get(Uri.parse(url + '/api/quizList/' + classID));
    final parsedData = jsonDecode(response.body);

    List<dynamic> newData = parsedData['quiz'];
    List<Quiz> rQuiz = [];
    for (var e in newData) {
      getQuestions(e['quizID'].toString()).then((questions) {
        rQuiz.add(Quiz(
            e['quizID'].toString(),
            classID,
            e['quizName'],
            DateTime.now(),
            DateTime.now(),
            e['length'],
            questions,
            e['weight']));

        setState(() {
          classQuiz = rQuiz;
        });
      });
    }
  }

  Future<List<Question>> getQuestions(quizID) async {
    List<Question> questions;
    final response =
        await http.get(Uri.parse(url + '/api/getQuestionQuiz/' + quizID));
    final parsedData = jsonDecode(response.body);
    List<dynamic> newData = parsedData['message'];
    questions = newData
        .map((e) =>
            Question('', e['question'], e['listAnswer'], e['correctAnswer']))
        .toList();
    return questions;
  }

  @override
  Widget build(BuildContext context) {
    if (classQuiz == null) {
      getQuiz();
    }
    final Class selectedClass = widget.selectedClass;
    final void Function(Widget screen) setScreen = widget.setScreen;

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
                if (classQuiz != null)
                  for (var quiz in classQuiz!)
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
                    builder: (ctx) => AddQuizScreen(
                      selectedClass: selectedClass,
                      addQuiz: (newQuiz) {
                        setState(() {
                          classQuiz!.add(newQuiz);
                        });
                      },
                    ),
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
