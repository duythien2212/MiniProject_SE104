import 'package:flutter/material.dart';
import 'package:new_project/data/currentQuizList.dart';
import 'package:new_project/utils/app_styles.dart';
import 'package:new_project/utils/widgets.dart';

class CurrentQuizPage extends StatefulWidget {
  const CurrentQuizPage({super.key});

  @override
  State<CurrentQuizPage> createState() => _CurrentQuizPageState();
}

class _CurrentQuizPageState extends State<CurrentQuizPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.only(top: height / 15, bottom: height / 25, left: 30, right: 30),
      height: height,
      width: width,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: SingleChildScrollView(
              child: Table(
                columnWidths: <int, TableColumnWidth>{
                  0: const FlexColumnWidth(),
                  1: FixedColumnWidth(width / 12),
                  2: FixedColumnWidth(width / 12),
                  3: FixedColumnWidth(width / 5),
                },
                border: TableBorder.all(color: AppThemes.headingColor),
                children: [
                  headingRow(),
                  for (var quizInfor in currentQuizs) currentQuizItem(quizInfor),
                ],
              ),
            ),
          ),
          Positioned(bottom: 0, right: 10, child: settingButton(() => null, "Get Result", height, width / 2))
        ],
      ),
    );
  }
}

TableRow headingRow() {
  return TableRow(children: [
    Text("Quiz", textAlign: TextAlign.center, style: tableHeadingTextStyle()),
    Text("Try", textAlign: TextAlign.center, style: tableHeadingTextStyle()),
    Text("Score", textAlign: TextAlign.center, style: tableHeadingTextStyle()),
    Text("Date", textAlign: TextAlign.center, style: tableHeadingTextStyle()),
  ]);
}

TableRow currentQuizItem(CurrentQuiz quizInfor) {
  return TableRow(children: [
    Text('    ${quizInfor.quizName}-${quizInfor.quizClass}', textAlign: TextAlign.left, style: tableItemTextStyle()),
    Text((quizInfor.tryTime).toString(), textAlign: TextAlign.center, style: tableItemTextStyle()),
    Text(quizInfor.score.toString(), textAlign: TextAlign.center, style: tableItemTextStyle()),
    Text(quizInfor.date.toString(), textAlign: TextAlign.center, style: tableItemTextStyle()),
  ]);
}
