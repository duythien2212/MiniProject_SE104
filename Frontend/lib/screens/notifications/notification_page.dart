import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_project/data/information.dart';
import 'package:new_project/data/notification.dart';
import 'package:new_project/screens/notifications/createNotification.dart';
import 'package:new_project/utils/app_styles.dart';
import 'package:http/http.dart' as http;

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NotificationPageState();
  }
}

class _NotificationPageState extends State<NotificationPage> {
  List<Notificate>? notifications;

  void addNotification(Notificate notification) {
    setState(() {
      notifications!.add(notification);
    });
  }

  Future<void> getNotificates() async {
    final response = await http
        .get(Uri.parse(url + '/api/notification/' + userinfor.userName));
    final parsedData = jsonDecode(response.body);
    List<dynamic> newData = parsedData['notifications'];
    setState(() {
      notifications = newData
          .map(
            (e) => Notificate(e['title'], e['content'], 'KHTN2022',
                DateTime.parse(e['date'])),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 8;
    final width = MediaQuery.of(context).size.width / 3;
    if (notifications == null) getNotificates();
    return Container(
      padding: EdgeInsets.all(20),
      color: AppThemes.mainScreenBackroundColor,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 80.0,
                child: ListView(
                  children: [
                    const SizedBox(height: 20),
                    if (notifications != null)
                      ...notifications!.map((item) {
                        return notificationField(item, height, width);
                      }),
                  ],
                ),
              ),
            ),
            if (userinfor.isTeacher)
              IconButton.filledTonal(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (ctx) => createNotificationScreen(
                            addNotification: addNotification,
                          ));
                },
                icon: const Icon(Icons.add),
              ),
          ],
        ),
      ),
    );
  }
}

Widget notificationField(Notificate notification, double height, double width) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    height: height,
    decoration: BoxDecoration(
      color: AppThemes.navigationRailBackroundColor,
      borderRadius: BorderRadius.circular(50),
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: width / 10, top: height / 18),
          alignment: Alignment.topLeft,
          child: Text(
            notification.title,
            style: const TextStyle(),
          ),
        ),
        const Spacer(),
        Center(
            child: Text(
          notification.message,
          style: TextStyle(color: AppThemes.buttonColor, fontSize: height / 6),
        )),
        const Spacer(),
        Container(
          alignment: Alignment.bottomRight,
          padding: EdgeInsets.only(right: width / 10, bottom: height / 18),
          child: Text(
            'Time: ${notification.time}',
            style: const TextStyle(),
          ),
        ),
      ],
    ),
  );
}
