import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/bloc/list_of_todos_bloc.dart';
import 'package:todo_app/model/list_of_todos.dart';
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
  String _appBarTitle = "Today";

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ListOfTodos>>(
        stream: _listOfTodosBloc.previewListOfTodosStream,
        initialData: <ListOfTodos>[],
        builder: (context, snapshot) {
          return Stack(
            children: [
              Scaffold(
                appBar: MainScreenAppBar(
                  title: _appBarTitle,
                  appBar: AppBar(),
                ),
                drawer: MainScreenDrawer(_listOfTodosBloc),
                body: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          ListOfTodosPreview(snapshot.data[index]),
                    ),
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
