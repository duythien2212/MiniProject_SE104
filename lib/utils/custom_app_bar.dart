import 'package:flutter/material.dart';
import 'package:new_project/screens/startScreen/start_screen.dart';
import 'package:new_project/utils/app_styles.dart';
import 'package:new_project/utils/functions.dart';
import 'package:new_project/utils/widgets.dart';

class StartScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titles;

  const StartScreenAppBar({Key? key, required this.titles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(
        child: Text(
          titles,
          style: const TextStyle(fontSize: 30),
        ),
      ),
      backgroundColor: AppThemes.headingColor,
      foregroundColor: AppThemes.headingTextColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titles;

  const MainAppBar({Key? key, required this.titles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Image.asset(logoPath),
      // actions: [logoutMainButton(() => null)],
      title: Center(child: Text(titles, style: const TextStyle(fontSize: 30))),
      actions: [
        logoutMainButton(() {
          navigateToPage(context, const StartScreen());
        })
      ],
      backgroundColor: AppThemes.headingColor,
      foregroundColor: AppThemes.headingTextColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
