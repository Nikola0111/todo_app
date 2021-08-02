import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/colors.dart';
import 'package:todo_app/model/values.dart';

class ErrorDialog extends StatelessWidget {
  final String title;

  ErrorDialog(this.title);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(
            fontSize: 15,
            color: darkText,
            fontFamily: "OpenSans",
            fontWeight: FontWeight.bold),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              "Close",
              style: createTaskTitleStyle,
            ))
      ],
    );
  }
}
