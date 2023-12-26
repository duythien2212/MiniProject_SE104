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
  final List<Notificate> _notification = [];
  int _selectedIndex = 1;

  void switchScreen(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(titles: appName),
      body: Expanded(
        child: Row(
          children: [
            Column(
              children: [
                DrawerListTile(
                  title: 'Notifications',
                  icon: const Icon(Icons.notifications),
                  index: 0,
                  currentIndex: _selectedIndex,
                  switchScreen: switchScreen,
                ),
                DrawerListTile(
                  title: 'Current Quiz',
                  icon: const Icon(Icons.question_mark),
                  index: 1,
                  currentIndex: _selectedIndex,
                  switchScreen: switchScreen,
                ),
                DrawerListTile(
                  title: 'Quiz List',
                  icon: const Icon(Icons.quiz),
                  index: 2,
                  currentIndex: _selectedIndex,
                  switchScreen: switchScreen,
                ),
                DrawerListTile(
                  title: 'Account',
                  icon: const Icon(Icons.account_box),
                  index: 3,
                  currentIndex: _selectedIndex,
                  switchScreen: switchScreen,
                ),
                DrawerListTile(
                  title: 'Setting',
                  icon: const Icon(Icons.settings),
                  index: 4,
                  currentIndex: _selectedIndex,
                  switchScreen: switchScreen,
                ),
              ],
            ),
            Row(
              children: [
                if (_selectedIndex == 0)
                  NotificationPage(notificates: _notification),
                if (_selectedIndex == 1) curentQuizPage(),
                if (_selectedIndex == 2) quizListPage(),
                if (_selectedIndex == 3) const ProfilePage(),
                if (_selectedIndex == 4) settingPage(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatefulWidget {
  const DrawerListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.index,
    required this.currentIndex,
    required this.switchScreen,
  });
  final Icon icon;
  final String title;
  final int index, currentIndex;
  final void Function(int index) switchScreen;

  @override
  State<StatefulWidget> createState() {
    return _DrawerListTileState();
  }
}

class _DrawerListTileState extends State<DrawerListTile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ListTile(
        leading: widget.icon,
        selectedColor: AppThemes.headingColor,
        selectedTileColor: AppThemes.headingTextColor,
        title: Text(
          widget.title,
        ),
        selected: widget.index == widget.currentIndex,
        onTap: () {
          widget.switchScreen(widget.index);
        },
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
