import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/colors.dart';
import 'package:todo_app/model/list_of_todos.dart';

import 'add_list_dialog.dart';

class DrawerListsListItem extends StatelessWidget {
  final ListOfTodos listOfTodos;
  final Function editButtonFunction;
  final Function listDetailsFunction;

  DrawerListsListItem(
      {this.listOfTodos, this.editButtonFunction, this.listDetailsFunction});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        listDetailsFunction(listOfTodos.id, listOfTodos.name);
        Navigator.of(context).pop();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        height: 30,
        child: Row(
          children: [
            Expanded(
                child: Text(
              listOfTodos.name,
              style: TextStyle(
                  fontFamily: "OpenSans", fontSize: 14, color: lightGreyText),
            )),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => AddEditListDialog(
                        saveFunction: editButtonFunction, todo: listOfTodos));
              },
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Icon(
                  Icons.edit,
                  color: lightGreyText,
                  size: 15,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
