import 'package:flutter/material.dart';
import 'package:new_project/data/quizList.dart';
import 'package:new_project/utils/widgets.dart';

class AddQuizScreen extends StatefulWidget {
  const AddQuizScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _AddQuizScreenState();
  }
}

class _AddQuizScreenState extends State<AddQuizScreen> {
  DateTime startTime = DateTime.now(), endTime = DateTime.now();

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

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(100),
        height: screenHeight,
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
            customTextField(screenWidth * 5, screenHeight, 'Enter quiz name'),
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
            customTextField(screenWidth * 5, screenHeight, 'Enter length'),
            customTextField(screenWidth * 5, screenHeight, 'Enter weight'),
            customTextField(
                screenWidth * 5, screenHeight, 'Enter notification'),
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
