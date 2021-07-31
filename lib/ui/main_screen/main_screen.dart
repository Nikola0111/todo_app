import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/bloc/list_of_todos_bloc.dart';
import 'package:todo_app/model/main_screen_title_data.dart';
import 'package:todo_app/ui/common/loading_layer.dart';
import 'package:todo_app/ui/main_screen/list_of_todos_preview/list_of_todos_preview.dart';
import 'package:todo_app/ui/main_screen/main_screen_appbar.dart';
import 'package:todo_app/ui/main_screen/drawer/main_screen_drawer.dart';

class MainScreen extends StatefulWidget {
  @override
  State createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ListOfTodosBloc _listOfTodosBloc = ListOfTodosBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MainScreenTitleTodoData>(
        stream: _listOfTodosBloc.mainScreenDataStream,
        initialData: MainScreenTitleTodoData("", []),
        builder: (context, snapshot) {
          return Stack(
            children: [
              Scaffold(
                appBar: MainScreenAppBar(
                  title: snapshot.data.title,
                  appBar: AppBar(),
                ),
                drawer: MainScreenDrawer(_listOfTodosBloc),
                body: SingleChildScrollView(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.listsOfTodos.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        ListOfTodosPreview(snapshot.data.listsOfTodos[index]),
                  ),
                ),
              ),
              snapshot.connectionState == ConnectionState.waiting
                  ? LoadingLayer()
                  : Container()
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _listOfTodosBloc.getListsAndTodos();
  }

  @override
  void dispose() {
    _listOfTodosBloc.dispose();
    super.dispose();
  }
}
