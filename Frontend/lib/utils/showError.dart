import 'package:flutter/material.dart';

void showError(context, message) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(
        'Error',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(ctx);
          },
          child: const Text('Ok'),
        ),
      ],
    ),
  );
}
