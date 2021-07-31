import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/model/colors.dart';
import 'package:todo_app/model/list_of_todos.dart';
import 'package:todo_app/services/todo_service.dart';
import 'package:todo_app/ui/main_screen/list_of_todos_preview/todo_list_item.dart';

class ListOfTodosPreview extends StatefulWidget {
  final ListOfTodos _listOfTodos;

  ListOfTodosPreview(this._listOfTodos);

  @override
  State createState() => _ListOfTodosPreviewState();
}

class _ListOfTodosPreviewState extends State<ListOfTodosPreview> {
  final TodoService _todoService = TodoService();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 28),
            width: double.infinity,
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: appBarColor, width: 1))),
            padding: EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  widget._listOfTodos.name,
                  style: TextStyle(
                      color: searchButtonColor,
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.w600,
                      fontSize: 17),
                )),
                widget._listOfTodos.name == "Overdue"
                    ? Expanded(
                        child: Text(
                          "Reschedule",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: focusedInputBorder,
                              fontFamily: "OpenSans",
                              fontSize: 15),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget._listOfTodos.todos.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => Slidable(
              child: TodoListItem(
                  checkFunction: _completeTodoFunction,
                  todo: widget._listOfTodos.todos[index],
                  isOverdue:
                      widget._listOfTodos.name == "Overdue" ? true : false),
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.2,
              secondaryActions: [
                SlideAction(
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  onTap: () => _deleteTodo(widget._listOfTodos.todos[index].id),
                  color: focusedInputBorder,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _completeTodoFunction(int id, bool status) {
    _todoService.changeTodoStatus(id, status);
  }

  _deleteTodo(int id) {
    _todoService.deleteTodo(id);
    setState(() {
      widget._listOfTodos.todos.removeWhere((element) => element.id == id);
    });
  }
}
