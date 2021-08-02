import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/bloc/list_of_todos_bloc.dart';
import 'package:todo_app/model/colors.dart';
import 'package:todo_app/model/list_of_todos.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/ui/common/error_dialog.dart';
import 'package:todo_app/ui/main_screen/create_task_bottom_sheet/bottom_sheet_task_name_field.dart';
import 'package:todo_app/ui/main_screen/create_task_bottom_sheet/select_date_bottom_sheet.dart';
import 'package:todo_app/ui/main_screen/create_task_bottom_sheet/select_todo_list_bottom_sheet.dart';

class CreateTaskBottomSheet extends StatefulWidget {
  final List<ListOfTodos> _listOfTodoTitles;
  final ListOfTodosBloc _listOfTodosBloc;

  CreateTaskBottomSheet(
      this._listOfTodoTitles, this._listOfTodosBloc);

  @override
  State createState() => _CreateTaskBottomSheetState();
}

class _CreateTaskBottomSheetState extends State<CreateTaskBottomSheet> {
  String taskName = "";
  DateTime date;
  ListOfTodos chosenList;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.only(top: 20, bottom: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BottomSheetTaskNameField(
              onTaskNameChanged: (value) => setState(() => taskName = value)),
          SizedBox(height: 14),
          SelectDateBottomSheet(onDateChanged: (value) => date = value),
          SizedBox(height: 14),
          SelectTodoListBottomSheet(widget._listOfTodoTitles,
              onListChanged: (value) => chosenList = value),
          SizedBox(height: 20),
          _buildCreateTodoButton()
        ],
      ),
    );
  }

  Widget _buildCreateTodoButton() {
    return Container(
      width: 200,
      child: ButtonTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        height: 40,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled))
                  return lightGreyText;
                else
                  return focusedInputBorder;
              },
            ),
          ),
          onPressed: taskName.length >= 4 ? () => createTodo() : null,
          child: Text("Create task",
              style: TextStyle(
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: white)),
        ),
      ),
    );
  }

  createTodo() async {
    if (date == null) {
      date = DateTime.now();
    }

    bool succeeded = await widget._listOfTodosBloc.createTask(
        Todo(date: date, listName: chosenList.name, todo: taskName),
        chosenList.id);

    if (!succeeded) {
      return showErrorDialog(
          "Todo with given name already exists in the selected list");
    }

    Navigator.of(context).pop();
  }

  showErrorDialog(String title) {
    return showDialog(
        context: context, builder: (context) => ErrorDialog(title));
  }

  @override
  void initState() {
    super.initState();
    chosenList = widget._listOfTodoTitles[0];
  }
}
