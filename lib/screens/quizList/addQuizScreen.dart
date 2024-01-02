import 'package:flutter/material.dart';
import 'package:new_project/data/quizList.dart';
import 'package:new_project/models/class.dart';
import 'package:new_project/models/question.dart';
import 'package:new_project/models/quiz.dart';
import 'package:new_project/utils/custom_text_field.dart';

class AddQuizScreen extends StatefulWidget {
  const AddQuizScreen(
      {super.key, required this.addQuiz, required this.selectedClass});
  final void Function(Quiz newQuiz) addQuiz;
  final Class selectedClass;
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
  String notifications = '';

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
    if (pickedDate != null) {
      setState(() {
        dates[i] = pickedDate;
      });
    }
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
                name: 'Length (minutes)',
                onChange: (input) {
                  length = int.parse(input);
                }).createTextField(),
            TextInput(
                name: 'Weight',
                onChange: (input) {
                  weight = double.parse(input);
                }).createTextField(),
            Row(
              children: [
                const Text('Select dates:'),
                IconButton(
                  onPressed: () {
                    _presentDatePicker(0);
                  },
                  icon: const Icon(Icons.calendar_month),
                ),
                Text(
                    'Start date: ${dates[0]!.day}/${dates[0]!.month}/${dates[0]!.year}'),
                const SizedBox(width: 50),
                IconButton(
                  onPressed: () {
                    _presentDatePicker(1);
                  },
                  icon: const Icon(Icons.calendar_month),
                ),
                Text(
                    'End date: ${dates[1]!.day}/${dates[1]!.month}/${dates[1]!.year}'),
              ],
            ),
            TextInput(
                name: 'Notifications',
                onChange: (input) {
                  notifications = input;
                }).createTextField(),
            TextInput(
                name: 'Number of question (number)',
                onChange: (input) {
                  setState(() {
                    nQuestion = int.parse(input);
                  });
                }).createTextField(),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Import questions'),
            ),
            const SizedBox(height: 50),
            for (var i = 0; i < nQuestion; i++)
              createQuestion(i, setQuestion, setAnswer, setCorrectAnswer,
                  questions[i], answers[i], correctAnswers[i] + 1),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    List<Question> newQuestionList = [];
                    for (var i = 0; i < nQuestion; i++) {
                      newQuestionList.add(Question(
                          '', questions[i], answers[i], correctAnswers[i]));
                    }
                    widget.addQuiz(Quiz(
                        'Q' + quizList.length.toString(),
                        widget.selectedClass.classID,
                        quizName,
                        dates[0]!,
                        dates[1]!,
                        length.toDouble(),
                        newQuestionList,
                        weight.toInt(),
                        notifications));
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget createQuestion(index, setQuestion, setAnswer, setCorrectAnswer,
    initialQuestion, initialAnswers, initialCorrectAnswer) {
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
            controller: TextEditingController(text: initialQuestion),
            decoration: const InputDecoration(
              label: Text('Question'),
            ),
          ),
          for (var answerID = 0; answerID < 4; answerID++)
            TextField(
              onChanged: (input) {
                setAnswer(index, answerID, input);
              },
              controller: TextEditingController(text: initialAnswers[answerID]),
              decoration: const InputDecoration(
                label: Text('Answer'),
              ),
            ),
          TextField(
            onChanged: (input) {
              setCorrectAnswer(index, input);
            },
            controller:
                TextEditingController(text: initialCorrectAnswer.toString()),
            decoration: const InputDecoration(
              label: Text('Correct answer (1-4)'),
            ),
          )
        ],
      ),
    ),
  );
}