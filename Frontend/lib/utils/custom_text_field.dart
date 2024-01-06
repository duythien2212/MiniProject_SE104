import 'package:flutter/material.dart';

class customTextField extends StatelessWidget {
  const customTextField(
      {super.key,
      required this.controller,
      required this.text,
      required this.screenWidth,
      required this.screenHeight});
  final TextEditingController controller;
  final String text;
  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth / 5,
      height: screenHeight / 11,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(
            fontSize: MediaQuery.of(context).size.height / 37,
          ),
        ),
      ),
    );
  }
}

class TextInput {
  TextInput({required this.name, required this.onChange});
  String name;
  final void Function(String input) onChange;
  TextField createTextField() {
    return TextField(
      onChanged: onChange,
      decoration: InputDecoration(
        label: Text(name),
      ),
    );
  }
}
