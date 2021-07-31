import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/model/colors.dart';
import 'package:todo_app/model/todo.dart';

class TodoListItem extends StatefulWidget {
  final Todo todo;
  final bool isOverdue;
  final Function checkFunction;

  TodoListItem({this.todo, this.isOverdue, this.checkFunction});

  @override
  State createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  final DateFormat _formatter = DateFormat("dd MMMM yyyy");

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: appBarColor, width: 1))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [_buildFirstRow(), _buildSecondRow()],
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
              onChanged: widget.isOverdue ? null : (value) {
                widget.checkFunction(widget.todo.id);
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
        // InkWell(
        //   onTap: () {},
        //   child: Container(
        //     height: 20,
        //     width: 20,
        //     child: Icon(
        //       Icons.edit,
        //       color: lightGreyText,
        //       size: 15,
        //     ),
        //   ),
        // )
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
                color: widget.isOverdue ? errorTextColor : hintInputColor, fontFamily: "OpenSans", fontSize: 13),
          ),
        ),
        Expanded(
            child: Text(
          widget.todo.listName,
          textAlign: TextAlign.right,
          style: TextStyle(
              color: hintInputColor, fontFamily: "OpenSans", fontSize: 13),
        ))
      ],
    );
  }
}
