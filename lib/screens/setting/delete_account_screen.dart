import 'package:flutter/material.dart';
import 'package:new_project/data/information.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(loginInput.username + " " + loginInput.password),
    );
  }
}
