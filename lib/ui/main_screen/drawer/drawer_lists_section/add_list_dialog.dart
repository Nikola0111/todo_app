import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/colors.dart';
import 'package:todo_app/model/list_of_todos.dart';

class AddEditListDialog extends StatefulWidget {
  final Function saveFunction;
  final ListOfTodos todo;

  AddEditListDialog({this.saveFunction, this.todo});

  @override
  State createState() => _AddEditListDialogState();
}

class _AddEditListDialogState extends State<AddEditListDialog> {
  String listName;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        listName == null ? "Enter list name" : "Edit list name",
        style: TextStyle(
            fontFamily: "OpenSans",
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: darkText),
      ),
      content: TextFormField(
        initialValue: widget.todo == null ? null : widget.todo.name,
        onChanged: (value) {
          setState(() {
            listName = value;
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
            child: Text(widget.todo == null ? "Create" : "Edit",
                style: TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w600,
                    color: _checkButtonCanClick() ? darkText : lightGreyText)))
      ],
    );
  }

  bool _checkButtonCanClick() {
    if (listName == null) return false;

    if (listName.isEmpty) return false;

    if(widget.todo != null)
      if(widget.todo.name == listName) return false;

    return true;
  }

  _saveFunction() {
    ListOfTodos listOfTodos;
    if(widget.todo == null) {
      listOfTodos = ListOfTodos(name: listName);
    }

    if(widget.todo != null) {
      listOfTodos = ListOfTodos(id: widget.todo.id,name: listName);
    }

    widget.saveFunction(listOfTodos);
    Navigator.of(context).pop();
  }
}
