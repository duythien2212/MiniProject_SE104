import 'package:new_project/models/question.dart';

class Quiz {
  Quiz(this.quizID, this.classID, this.quizName, this.startTime, this.endTime,
      this.length, this.questions, this.weight);
  String quizID, classID, quizName;
  DateTime startTime, endTime;
  double length;
  var weight = 0;
  List<Question> questions;
}
