import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/bloc/list_of_todos_bloc.dart';
import 'package:todo_app/model/colors.dart';
import 'package:todo_app/model/list_of_todos.dart';
import 'package:todo_app/services/todo_service.dart';
import 'package:todo_app/ui/common/error_dialog.dart';
import 'package:todo_app/ui/main_screen/list_of_todos_preview/todo_list_item.dart';

class ListOfTodosPreview extends StatefulWidget {
  final ListOfTodos _listOfTodos;
  final ListOfTodosBloc _listOfTodosBloc;

  ListOfTodosPreview(this._listOfTodos, this._listOfTodosBloc);

  @override
  State createState() => _ListOfTodosPreviewState();
}

class _ListOfTodosPreviewState extends State<ListOfTodosPreview> {
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
              child: widget._listOfTodos.todos[index].done
                  ? Container()
                  : TodoListItem(
                      updateFunction: _updateTodo,
                      checkFunction: _updateTodoStatus,
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
                  onTap: () => _deleteTodo(widget._listOfTodos.todos[index].id,
                      widget._listOfTodos.todos[index].date),
                  color: focusedInputBorder,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _updateTodoStatus(int id, bool status, DateTime dateTime) async {
    bool succeeded = await widget._listOfTodosBloc.changeTodoStatus(id, status);

    if (succeeded) {
      widget._listOfTodosBloc.updateTodoInMap(id, status, dateTime);
    }
  }

  _updateTodo(int id, String todo, DateTime dateTime) async {
    await widget._listOfTodosBloc.updateTodo(id, todo, dateTime);
  }

  _deleteTodo(int id, DateTime date) {
    widget._listOfTodosBloc.deleteTodo(id, date);
    setState(() {
      widget._listOfTodos.todos.removeWhere((element) => element.id == id);
    });
  }
}
