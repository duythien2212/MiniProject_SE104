import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_project/data/currentQuizList.dart';
import 'package:new_project/data/information.dart';
import 'package:new_project/utils/app_styles.dart';
import 'package:new_project/utils/widgets.dart';
import 'package:http/http.dart' as http;

class CurrentQuizPage extends StatefulWidget {
  const CurrentQuizPage({super.key});

  @override
  State<CurrentQuizPage> createState() => _CurrentQuizPageState();
}

class _CurrentQuizPageState extends State<CurrentQuizPage> {
  List<CurrentQuiz>? currentQuizs;
  Future<void> getUserQuiz() async {
    final response =
        await http.get(Uri.parse(url + '/api/score/' + userinfor.userName));
    final parsedData = jsonDecode(response.body);
    List<dynamic> newData = parsedData['message'];
    setState(() {
      currentQuizs = newData
          .map((e) =>
              CurrentQuiz(e['quizName'], '', e['try'], e['score'], e['date']))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    if (currentQuizs == null) {
      getUserQuiz();
    }
    return Container(
      padding: EdgeInsets.only(
          top: height / 15, bottom: height / 25, left: 30, right: 30),
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
                  if (currentQuizs != null)
                    for (var quizInfor in currentQuizs!)
                      currentQuizItem(quizInfor),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              right: 10,
              child: settingButton(() => null, "Get Result", height, width / 2))
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
    Text('    ${quizInfor.quizName}-${quizInfor.quizClass}',
        textAlign: TextAlign.left, style: tableItemTextStyle()),
    Text((quizInfor.tryTime).toString(),
        textAlign: TextAlign.center, style: tableItemTextStyle()),
    Text(quizInfor.score.toString(),
        textAlign: TextAlign.center, style: tableItemTextStyle()),
    Text(quizInfor.date.toString(),
        textAlign: TextAlign.center, style: tableItemTextStyle()),
  ]);
}
