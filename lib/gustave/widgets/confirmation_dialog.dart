import 'package:flutter/material.dart';

abstract class ConfirmationDialogue {
  final BuildContext context;
  abstract final String title;
  abstract final String buttonText;

  ConfirmationDialogue(this.context);

  void onPressed();

  Future<String?> show() {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            actions: <Widget>[
              TextButton(
                child: Text(buttonText),
                onPressed: onPressed,
              ),
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context, 'Cancel');
                },
              ),
            ],
          );
        });
  }
}
