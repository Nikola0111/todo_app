import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/colors.dart';

class EditTodoDialog extends StatefulWidget {
  final Function saveFunction;

  EditTodoDialog({this.saveFunction});

  @override
  State createState() => _EditTodoDialog();
}

class _EditTodoDialog extends State<EditTodoDialog> {
  String todoName;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Enter todo name",
        style: TextStyle(
            fontFamily: "OpenSans",
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: darkText),
      ),
      content: TextFormField(
        onChanged: (value) {
          setState(() {
            todoName = value;
          });
        },
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              "Cancel",
              style: TextStyle(
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w600,
                  color: darkText),
            )),
        TextButton(
            onPressed: _checkButtonCanClick() ? () => _saveFunction() : null,
            child: Text("Edit",
                style: TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w600,
                    color: _checkButtonCanClick() ? darkText : lightGreyText)))
      ],
    );
  }

  bool _checkButtonCanClick() {
    if (todoName == null) return false;

    if (todoName.isEmpty) return false;

    if(todoName.length < 4) return false;

    return true;
  }

  _saveFunction() {
    widget.saveFunction(todoName);
    Navigator.of(context).pop();
  }
}
