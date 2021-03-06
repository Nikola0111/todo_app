import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/model/colors.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/ui/main_screen/list_of_todos_preview/edit_todo_dialog.dart';

class TodoListItem extends StatefulWidget {
  final Todo todo;
  final bool isOverdue;
  final Function checkFunction;
  final Function updateFunction;

  TodoListItem({this.todo, this.isOverdue, this.checkFunction, this.updateFunction});

  @override
  State createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  final DateFormat _formatter = DateFormat("dd MMMM yyyy");

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 28, right: 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildFirstRow(),
          _buildSecondRow(),
          Container(
            padding: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: appBarColor, width: 1))),
          )
        ],
      ),
    );
  }

  Row _buildFirstRow() {
    return Row(
      children: [
        SizedBox(
          child: Checkbox(
              value: isChecked,
              activeColor: focusedInputBorder,
              shape: CircleBorder(),
              onChanged: widget.isOverdue
                  ? null
                  : (value) {
                      widget.checkFunction(widget.todo.id, value, widget.todo.date);
                      setState(() {
                        isChecked = !isChecked;
                      });
                    }),
          height: 24,
          width: 24,
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            widget.todo.todo,
            style: TextStyle(
                decoration: isChecked
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                fontSize: 15,
                fontFamily: "OpenSans",
                color: drawerTextColor),
          ),
        ),
        widget.todo.listName == null ? InkWell(
          onTap: () {
            showEditTodoDialog();
          },
          child: Container(
            height: 20,
            width: 20,
            child: Icon(
              Icons.edit,
              color: lightGreyText,
              size: 15,
            ),
          ),
        ) : Container()
      ],
    );
  }

  Row _buildSecondRow() {
    return Row(
      children: [
        SizedBox(height: 20, width: 24),
        SizedBox(
          height: 20,
          width: 34,
          child: Icon(
            Icons.calendar_today_outlined,
            color: widget.isOverdue ? errorTextColor : hintInputColor,
            size: 13,
          ),
        ),
        Container(
          child: Text(
            _formatter.format(
              widget.todo.date,
            ),
            style: TextStyle(
                color: widget.isOverdue ? errorTextColor : hintInputColor,
                fontFamily: "OpenSans",
                fontSize: 13),
          ),
        ),
        widget.todo.listName != null ? Expanded(
            child: Text(
              widget.todo.listName,
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: hintInputColor, fontFamily: "OpenSans", fontSize: 13),
            )) : Container()
      ],
    );
  }

  showEditTodoDialog() {
    return showDialog(context: context, builder: (context) => EditTodoDialog(saveFunction: editTodo,));
  }

  editTodo(String todoName) async{
    await widget.updateFunction(widget.todo.id, todoName, widget.todo.date);
    setState(() {
      widget.todo.todo = todoName;
    });
  }
}
