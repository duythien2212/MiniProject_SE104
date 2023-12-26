import 'package:flutter/material.dart';
import 'package:new_project/notification_page.dart';
import 'package:new_project/profile_page.dart';
import 'package:new_project/utils/app_styles.dart';
import 'package:new_project/utils/custom_app_bar.dart';
import 'package:new_project/utils/widgets.dart';
import 'package:new_project/data/notification.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 3;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: MainAppBar(titles: appName),
      body: Row(
        verticalDirection: VerticalDirection.down,
        children: [
          NavigationRail(
            extended: true,
            backgroundColor: const Color.fromARGB(31, 74, 137, 139),
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            selectedIndex: _selectedIndex,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.notifications_none_outlined),
                label: Text("Notification"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.list),
                label: Text("Current quiz"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.notifications_none_outlined),
                label: Text("Quiz list"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.notifications_none_outlined),
                label: Text("Profile"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.notifications_none_outlined),
                label: Text("Seting"),
              ),
            ],
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                notificationPage(notificates, screenHeight / 8, screenWidth / 3),
                curentQuizPage(),
                quizListPage(),
                profilePage(screenHeight, screenWidth),
                settingPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget curentQuizPage() {
  return Container(
    color: AppThemes.mainScreenBackroundColor,
    child: const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("QuizPage"),
        ],
      ),
    ),
  );
}

Widget quizListPage() {
  return Container(
    color: AppThemes.mainScreenBackroundColor,
    child: const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("quizListPage"),
        ],
      ),
    ),
  );
}

Widget settingPage() {
  return Container(
    color: AppThemes.mainScreenBackroundColor,
    child: const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("settingPage"),
        ],
      ),
    ),
  );
}
