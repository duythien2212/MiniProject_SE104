import 'package:flutter/material.dart';
import 'package:new_project/data/notification.dart';
import 'package:new_project/utils/custom_text_field.dart';

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
                  widget.addNotification(
                      Notificate(title, notify, classID, DateTime.now()));
                  Navigator.pop(context);
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
