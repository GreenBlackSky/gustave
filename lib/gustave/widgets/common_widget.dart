import 'package:flutter/material.dart';

Widget buildForm(Widget widget, widthFactor) {
  return Center(
      child: FractionallySizedBox(
    widthFactor: widthFactor,
    child: widget,
  ));
}

Widget buildButton(String text, Function callback) {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: TextButton(
      style: ButtonStyle(
        foregroundColor:
            MaterialStateColor.resolveWith((Set<MaterialState> states) {
          return Colors.white;
        }),
        backgroundColor:
            MaterialStateColor.resolveWith((Set<MaterialState> states) {
          return Colors.blue;
        }),
      ),
      onPressed: callback as void Function()?,
      child: Text(text),
    ),
  );
}

void displayError(BuildContext context, String text) {
  final bar = SnackBar(
    content: Text(text),
  );
  ScaffoldMessenger.of(context).showSnackBar(bar);
}
