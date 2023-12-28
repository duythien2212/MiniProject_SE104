import 'package:flutter/material.dart';
import 'package:new_project/models/quiz.dart';
import 'package:new_project/resultScreen.dart';
import 'package:new_project/utils/app_styles.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 270,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Question ${selectedQuestion + 1}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      currentQuestion.question,
                      style: Theme.of(context).textTheme.titleMedium,
                      softWrap: true,
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
                            } else {
                              changeQuestion(selectedQuestion);
                            }
                          },
                          child: Container(
                              width: width * 2 / 3,
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                currentQuestion.listAnswer[i],
                                style: Theme.of(context).textTheme.bodyMedium,
                              )),
                        ),
                      ),
                    const SizedBox(height: 50),
                    Container(
                      width: width - 270,
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppThemes.headingColor,
                          foregroundColor: AppThemes.headingTextColor,
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppThemes.headingTextColor,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) => ResultScreen(
                                quiz: widget.selectedQuiz,
                                selectedAnswer: selectedAnswer!,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Select questions',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(
                      width: 170,
                      height: 170,
                      child: SelectQuestion(
                        nQuestion: nQuestion,
                        changeQuestion: changeQuestion,
                        selectedAnswer: selectedAnswer!,
                      ),
                    ),
                  ],
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
      {super.key,
      required this.nQuestion,
      required this.changeQuestion,
      required this.selectedAnswer});
  final int nQuestion;
  final void Function(int index) changeQuestion;
  final List<int> selectedAnswer;

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
              style: TextStyle(
                  color: selectedAnswer[i] == -1
                      ? Colors.black
                      : AppThemes.headingColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
      ],
    );
  }
}
