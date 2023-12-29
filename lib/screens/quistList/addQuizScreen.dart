import 'package:flutter/material.dart';
import 'package:new_project/data/quizList.dart';
import 'package:new_project/utils/custom_text_field.dart';

class AddQuizScreen extends StatefulWidget {
  const AddQuizScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _AddQuizScreenState();
  }
}

class _AddQuizScreenState extends State<AddQuizScreen> {
  int nQuestion = 0;
  String quizName = '';
  int length = 0;
  double weight = 0;
  List<String> questions = [];
  List<List<String>> answers = [];
  List<int> correctAnswers = [];

  List<DateTime?> dates = [DateTime.now(), DateTime.now()];
  void _presentDatePicker(i) async {
    final now = DateTime.now();
    final firstDate = now;
    final lastDate = DateTime(now.year + 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate);

    setState(() {
      dates[i] = pickedDate;
    });
  }

  void setQuestion(index, input) {
    questions[index] = input;
  }

  void setAnswer(questionID, answerID, input) {
    answers[questionID][answerID] = input;
  }

  void setCorrectAnswer(questionID, input) {
    correctAnswers[questionID] = int.parse(input) - 1;
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    while (questions.length < nQuestion) {
      questions.add('');
      answers.add(['', '', '', '']);
      correctAnswers.add(-1);
    }
    while (questions.length > nQuestion) {
      questions.removeLast();
      answers.removeLast();
      correctAnswers.removeLast();
    }
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Create question',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextInput(
                name: 'Quiz name',
                onChange: (input) {
                  quizName = input;
                }).createTextField(),
            TextInput(
                name: 'Number of question (number)',
                onChange: (input) {
                  setState(() {
                    nQuestion = int.parse(input);
                  });
                }).createTextField(),
            TextInput(
                name: 'Length (minutes)',
                onChange: (input) {
                  length = int.parse(input);
                }).createTextField(),
            TextInput(
                name: 'Weight',
                onChange: (input) {
                  weight = double.parse(input);
                }).createTextField(),
            for (var i = 0; i < nQuestion; i++)
              createQuestion(i, setQuestion, setAnswer, setCorrectAnswer),
          ],
        ),
      ),
    );
  }
}

class TextInput {
  TextInput({required this.name, required this.onChange});
  String name;
  final void Function(String input) onChange;
  TextField createTextField() {
    return TextField(
      onChanged: onChange,
      decoration: InputDecoration(
        label: Text(name),
      ),
    );
  }
}

Widget createQuestion(index, setQuestion, setAnswer, setCorrectAnswer) {
  return Card(
    child: Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Question ${index + 1}',
            style: const TextStyle(color: Colors.black54, fontSize: 16),
          ),
          TextField(
            onChanged: (input) {
              setQuestion(index, input);
            },
            decoration: const InputDecoration(
              label: Text('Question'),
            ),
          ),
          for (var answerID = 0; answerID < 4; answerID++)
            TextField(
              onChanged: (input) {
                setAnswer(index, answerID, input);
              },
              decoration: const InputDecoration(
                label: Text('Answer'),
              ),
            ),
          TextField(
            onChanged: (input) {
              setCorrectAnswer(index, input);
            },
            decoration: const InputDecoration(
              label: Text('Correct answer (1-4)'),
            ),
          )
        ],
      ),
    ),
  );
}
