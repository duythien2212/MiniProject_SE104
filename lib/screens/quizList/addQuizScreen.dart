import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:new_project/data/quizList.dart';
import 'package:new_project/models/class.dart';
import 'package:new_project/models/question.dart';
import 'package:new_project/models/quiz.dart';
import 'package:new_project/utils/custom_text_field.dart';
import 'package:new_project/utils/importFile.dart';

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

  void readQuestions(Uint8List? data) {
    if (data != null) {
      var excel = Excel.decodeBytes(data);
      questions = [];
      for (var table in excel.tables.keys) {
        var tableData = excel.tables[table];
        if (tableData != null) {
          for (var i = 1; i < tableData.rows.length; i++) {
            var row = tableData.rows[i];
            String questionID =
                i.toString(); // Sử dụng chỉ số dòng làm questionID
            String question =
                row[0]?.value?.toString() ?? ''; // Lấy câu hỏi từ cột A
            List<String> listAnswers = [
              row[1]?.value?.toString() ?? '', // Đáp án 1 từ cột B
              row[2]?.value?.toString() ?? '', // Đáp án 2 từ cột C
              row[3]?.value?.toString() ?? '', // Đáp án 3 từ cột D
              row[4]?.value?.toString() ?? '', // Đáp án 4 từ cột E
            ];
            int correctAnswer = int.parse(
                row[5]?.value?.toString() ?? '0'); // Đáp án đúng từ cột F

            questions.add(question);
            answers.add(listAnswers);
            correctAnswers.add(correctAnswer - 1);
          }
        }
      }
    }
    nQuestion = questions.length;

    setState(() {});
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
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  importFile(readQuestions);
                });
              },
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
                        '',
                        widget.selectedClass.classID,
                        quizName,
                        dates[0]!,
                        dates[1]!,
                        length.toDouble(),
                        newQuestionList,
                        weight.toInt()));
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
