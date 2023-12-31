import 'package:flutter/material.dart';
import 'package:new_project/screens/current/current_quiz_page.dart';
import 'package:new_project/screens/notifications/notification_page.dart';
import 'package:new_project/screens/profile/profile_page.dart';
import 'package:new_project/screens/quizList/selectClassScreen.dart';
import 'package:new_project/screens/setting/setting_page.dart';
import 'package:new_project/utils/app_styles.dart';
import 'package:new_project/utils/custom_app_bar.dart';
import 'package:new_project/utils/widgets.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void switchScreen(index) {
    setState(() {
      _selectedIndex = index;
      activeScreen = null;
    });
  }

  void setScreen(Widget screen) {
    setState(() {
      activeScreen = screen;
    });
  }

  Widget? activeScreen;

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      NotificationPage(),
      const CurrentQuizPage(),
      SelectClassScreen(setScreen: setScreen),
      const ProfilePage(),
      SettingPage(setScreen: setScreen),
    ];
    activeScreen ??= screens[_selectedIndex];
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
                  title: 'Quiz Result',
                  icon: const Icon(Icons.done_all_sharp),
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
            SizedBox(
              width: MediaQuery.of(context).size.width - 200,
              child: activeScreen,
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
