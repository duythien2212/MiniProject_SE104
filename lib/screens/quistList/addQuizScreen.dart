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
  DateTime startTime = DateTime.now(), endTime = DateTime.now();
  final TextEditingController lengthController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController notificationController = TextEditingController();
  final TextEditingController quizNameController = TextEditingController();

  @override
  void dispose() {
    lengthController.dispose();
    weightController.dispose();
    notificationController.dispose();
    quizNameController.dispose();
    super.dispose();
  }

  void _selectStartTime() async {
    final now = DateTime.now();
    final firstDate = DateTime.now();
    final lastDate = DateTime(now.year + 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate);

    setState(() {
      startTime = pickedDate!;
    });
  }

  void _selectEndTime() async {
    final now = DateTime.now();
    final firstDate = DateTime.now();
    final lastDate = DateTime(now.year + 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate);

    setState(() {
      endTime = pickedDate!;
    });
  }

  List<int> questionID = [];

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(100),
        width: screenWidth,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Create quiz',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            customTextField(
                screenWidth: screenWidth * 5,
                screenHeight: screenHeight,
                text: 'Enter quiz name',
                controller: quizNameController),
            _SelectTime(
              text: 'Start time',
              time: startTime,
              selectTime: _selectStartTime,
            ),
            _SelectTime(
              text: 'End time',
              time: endTime,
              selectTime: _selectEndTime,
            ),
            customTextField(controller: lenghtController, text: "Enter lenght", screenWidth: screenWidth*5, screenHeight: screenHeight),
            customTextField(controller: weightController, text: "Enter weight", screenWidth: screenWidth*5, screenHeight: screenHeight),
            customTextField(controller: notificationController, text: "Enter notificaton", screenWidth: screenWidth*5, screenHeight: screenHeight),
            for (var i in questionID)
              Row(
                children: [
                  CreateQuestion(key: Key(i.toString())),
                  IconButton.filledTonal(
                    onPressed: () {
                      setState(() {
                        questionID.remove(i);
                      });
                    },
                    icon: const Icon(Icons.remove),
                  )
                ],
              ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  questionID.add(questionID.length);
                });
              },
              child: const Text('Add question'),
            ),
            customTextField(
                screenWidth: screenWidth * 5,
                screenHeight: screenHeight,
                text: 'Enter length',
                controller: lengthController),
            customTextField(
                screenWidth: screenWidth * 5,
                screenHeight: screenHeight,
                text: 'Enter weight',
                controller: weightController),
            customTextField(
                screenWidth: screenWidth * 5,
                screenHeight: screenHeight,
                text: 'Enter notification',
                controller: notificationController),
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
                  onPressed: () {},
                  child: const Text('Add Quiz'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CreateQuestion extends StatelessWidget {
  const CreateQuestion({super.key});
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          customTextField(screenWidth, screenHeight, 'Enter question'),
          customTextField(screenWidth, screenHeight, 'Enter answer'),
          customTextField(screenWidth, screenHeight, 'Enter answer'),
          customTextField(screenWidth, screenHeight, 'Enter answer'),
          customTextField(screenWidth, screenHeight, 'Enter answer'),
        ],
      ),
    );
  }
}

class _SelectTime extends StatelessWidget {
  const _SelectTime(
      {super.key,
      required this.text,
      required this.time,
      required this.selectTime});
  final void Function() selectTime;
  final DateTime time;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            selectTime();
          },
          icon: const Icon(Icons.calendar_month),
        ),
        Text(
          '$text: ${time.day}/${time.month}/${time.year}',
        ),
      ],
    );
  }
}
