import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_project/models/quiz.dart';

class StartQuizScreen extends StatefulWidget {
  const StartQuizScreen({super.key, required this.selectedQuiz});
  final Quiz selectedQuiz;

  @override
  State<StatefulWidget> createState() {
    return _StartQuizScreenState();
  }
}

class _StartQuizScreenState extends State<StartQuizScreen> {
  int _selectedQuestion = 0;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var currentQuestion = widget.selectedQuiz.questions[_selectedQuestion];
    return Container(
      height: height,
      width: width,
      child: Expanded(
        child: Column(
          children: [
            Text(currentQuestion.question),
            const SizedBox(height: 30),
            for (var i = 0; i < currentQuestion.listAnswer.length; i++)
              Container(
                padding: const EdgeInsets.all(5),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Container(
                      width: width * 2 / 3,
                      child: Text(
                        currentQuestion.listAnswer[i],
                      )),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
