import 'package:flutter/material.dart';
import 'package:new_project/data/notification.dart';
import 'package:new_project/utils/app_styles.dart';

Widget notificationPage(List<Notificate> notificates, double height, double width) {
  return Container(
    color: AppThemes.mainScreenBackroundColor,
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 20),
          ...notificates.map((item) {
            return notificationField(item, height, width);
          }),
        ],
      ),
    ),
  );
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
          style: TextStyle(color: AppThemes.buttonColor, fontSize: height / 4),
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
