import 'package:flutter/material.dart';
import 'package:new_project/login_screen.dart';
import 'package:new_project/main_screen.dart';
import 'package:new_project/start_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
