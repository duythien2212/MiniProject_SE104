import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_project/data/information.dart';
import 'package:new_project/data/notification.dart';
import 'package:new_project/utils/custom_text_field.dart';
import 'package:http/http.dart' as http;

class createNotificationScreen extends StatefulWidget {
  const createNotificationScreen({super.key, required this.addNotification});
  final void Function(Notificate notification) addNotification;

  @override
  State<StatefulWidget> createState() {
    return _createNotificationScreenState();
  }
}

class _createNotificationScreenState extends State<createNotificationScreen> {
  String title = '', notify = '', classID = '';
  int responseStatus = 0;
  String responseMessage = '';
  Future<void> addNotify() async {
    final response = await http
        .post(Uri.parse(url + '/api/createNoti'),
            body: json.encode({
              'title': title,
              'content': notify,
              'classID': classID,
              'date': DateTime.now().toString(),
            }))
        .then((value) => value);
    var response_data = jsonDecode(response.body);
    responseMessage = response_data['message'];
    responseStatus = (response_data['status']);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text("Add notifications",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          TextInput(
            name: 'Title',
            onChange: (input) {
              title = input;
            },
          ).createTextField(),
          TextInput(
            name: 'Notifications',
            onChange: (input) {
              notify = input;
            },
          ).createTextField(),
          TextInput(
            name: 'Class ID',
            onChange: (input) {
              classID = input;
            },
          ).createTextField(),
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
                  addNotify().then((value) {
                    if (responseStatus == 1) {
                      widget.addNotification(
                          Notificate(title, notify, classID, DateTime.now()));
                      Navigator.pop(context);
                    } else {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text(
                            'Error',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          content: Text(responseMessage),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Ok')),
                          ],
                        ),
                      );
                    }
                  });
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
