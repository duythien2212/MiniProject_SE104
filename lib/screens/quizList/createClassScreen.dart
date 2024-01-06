import 'dart:convert';
import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:new_project/data/information.dart';
import 'package:new_project/models/class.dart';
import 'package:new_project/utils/custom_text_field.dart';
import 'package:new_project/utils/importFile.dart';
import 'package:http/http.dart' as http;
import 'package:new_project/utils/showError.dart';

class CreateClassScreen extends StatefulWidget {
  const CreateClassScreen(
      {super.key, required this.addClass, required this.getClasses});
  final void Function(Class newClass) addClass;
  final Future<void> Function() getClasses;

  @override
  State<StatefulWidget> createState() {
    return _CreateClassScreenState();
  }
}

class _CreateClassScreenState extends State<CreateClassScreen> {
  var nStudent = 0;
  String classID = '', className = '';
  List<String> studentIDs = [];
  String rMessage = '';
  int rStatus = 0;

  Future<void> createClass() async {
    final response = await http
        .post(Uri.parse(url + '/api/createClass/' + userinfor.userName),
            body: json.encode({
              'classID': classID,
              'className': className,
              'stoStudent': studentIDs,
            }))
        .then((value) => value);

    var response_data = jsonDecode(response.body);
    rMessage = response_data['message'];
    rStatus = response_data['status'];
  }

  void readStudentID(Uint8List? data) {
    if (data != null) {
      List<String> newStudentID = [];
      var excel = Excel.decodeBytes(data);
      for (var table in excel.tables.keys) {
        var tableData = excel.tables[table];
        if (tableData != null) {
          for (var i = 1; i < tableData.rows.length; i++) {
            var row = tableData.rows[i];
            String studentID = row[0]?.value?.toString() ?? ''; // Lấy studentID
            print(studentID);
            newStudentID.add(studentID);
          }
        }
      }
      studentIDs = newStudentID;
      nStudent = studentIDs.length;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    while (studentIDs.length < nStudent) {
      studentIDs.add('');
    }
    while (studentIDs.length > nStudent) {
      studentIDs.removeLast();
    }
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text('Create Class', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 30),
            TextInput(
              name: 'Class ID',
              onChange: (input) {
                classID = input;
              },
            ).createTextField(),
            TextInput(
              name: 'Class name',
              onChange: (input) {
                className = input;
              },
            ).createTextField(),
            TextInput(
              name: 'Number of students',
              onChange: (input) {
                setState(() {
                  nStudent = int.parse(input);
                });
              },
            ).createTextField(),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                importFile(readStudentID);
              },
              child: const Text('Import student ID'),
            ),
            const SizedBox(height: 20),
            if (nStudent > 0) const Text('Students'),
            for (int i = 0; i < nStudent; i++)
              TextField(
                controller: TextEditingController(text: studentIDs[i]),
                onChanged: (input) {
                  studentIDs[i] = input;
                },
                decoration: const InputDecoration(label: Text('Student ID')),
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    studentIDs.add(userinfor.userName);
                    createClass().then(
                      (value) {
                        if (rStatus == 1) {
                          widget.addClass(Class(
                              classID: classID,
                              teacherID: userinfor.userID,
                              className: className));
                          userinfor.userClasses.add(classID);
                          widget.getClasses().then((value) {
                            Navigator.pop(context);
                          });
                        } else {
                          showError(context, rMessage);
                        }
                      },
                    );
                  },
                  child: const Text('Save'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
