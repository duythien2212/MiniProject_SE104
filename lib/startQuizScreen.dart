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
  List<int>? selectedAnswer;
  int selectedQuestion = 0;

  void changeQuestion(index) {
    setState(() {
      selectedQuestion = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var nQuestion = widget.selectedQuiz.questions.length;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var currentQuestion = widget.selectedQuiz.questions[selectedQuestion];
    selectedAnswer ??= List.filled(nQuestion, -1);
    return Container(
      height: height,
      width: width,
      child: Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height / 4),
              Text(
                'Question ${selectedQuestion + 1}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    currentQuestion.question,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Container(
                    width: 170,
                    height: 170,
                    child: SelectQuestion(
                        nQuestion: nQuestion, changeQuestion: changeQuestion),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              for (var i = 0; i < currentQuestion.listAnswer.length; i++)
                Container(
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            (i == selectedAnswer![selectedQuestion])
                                ? Colors.white30
                                : Colors.white),
                    onPressed: () {
                      selectedAnswer![selectedQuestion] = i;
                      if (selectedQuestion + 1 < nQuestion) {
                        changeQuestion(selectedQuestion + 1);
                      }
                    },
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
      ),
    );
  }
}

class SelectQuestion extends StatelessWidget {
  const SelectQuestion(
      {super.key, required this.nQuestion, required this.changeQuestion});
  final int nQuestion;
  final void Function(int index) changeQuestion;

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(3),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      children: [
        for (int i = 0; i < nQuestion; i++)
          TextButton(
            onPressed: () {
              changeQuestion(i);
            },
            child: Text(
              (i + 1).toString(),
              softWrap: false,
            ),
          ),
      ],
    );
  }
}
