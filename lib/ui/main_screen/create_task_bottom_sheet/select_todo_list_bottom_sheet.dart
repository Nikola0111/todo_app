import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/colors.dart';
import 'package:todo_app/model/list_of_todos.dart';
import 'package:todo_app/model/values.dart';

class SelectTodoListBottomSheet extends StatefulWidget {
  final List<ListOfTodos> _list;
  final ValueChanged<ListOfTodos> onListChanged;

  SelectTodoListBottomSheet(this._list, {Key key, this.onListChanged}) : super(key: key);

  @override
  State createState() => _SelectTodoListBottomSheet();
}

class _SelectTodoListBottomSheet extends State<SelectTodoListBottomSheet> {
  ListOfTodos _selectedTodo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Task Name",
          style: createTaskTitleStyle,
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Container(
              width: 200,
              height: 60,
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 4, top: 4, left: 10),
                    focusColor: createTaskBorder,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: createTaskBorder)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: createTaskBorder))),
                value: _selectedTodo,
                items: widget._list
                    .map<DropdownMenuItem<ListOfTodos>>((ListOfTodos value) {
                  return DropdownMenuItem<ListOfTodos>(
                    value: value,
                    child: Text(
                      value.name,
                      style: TextStyle(
                          fontFamily: "OpenSans",
                          color: searchButtonColor,
                          fontSize: 15),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTodo = value;
                  });
                },
              ),
            ),
            Expanded(child: Container())
          ],
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _selectedTodo = widget._list[0];
  }
}
