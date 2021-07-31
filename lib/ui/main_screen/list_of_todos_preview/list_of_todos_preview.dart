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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
                widget._listOfTodos.name == "Overdue" ? Expanded(
                  child: Text(
                    "Reschedule",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: focusedInputBorder,
                        fontFamily: "OpenSans",
                        fontSize: 15),
                  ),
                ) : Container()
              ],
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget._listOfTodos.todos.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => Slidable(
              child: TodoListItem(
                  todo: widget._listOfTodos.todos[index],
                  checkFunction: completeTodoFunction,
                  isOverdue:
                      widget._listOfTodos.name == "Overdue" ? true : false),
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.16,
              secondaryActions: [
                SlideAction(
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  color: focusedInputBorder,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  
  completeTodoFunction(int id) {
    _todoService.changeTodoStatus(id);
    
    removeItemAfterTwoSec(id);
  }

  Timer _timer;
  int _start = 2;

  void removeItemAfterTwoSec(int id) {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            widget._listOfTodos.todos.removeWhere((element) => element.id == id);
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
