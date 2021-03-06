import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/bloc/list_of_todos_bloc.dart';
import 'package:todo_app/model/colors.dart';
import 'package:todo_app/model/list_of_todos.dart';
import 'package:todo_app/model/values.dart';
import 'package:todo_app/ui/main_screen/drawer/drawer_lists_section/lists_drawer_section.dart';
import 'package:todo_app/ui/main_screen/drawer/overdue_today_upcoming.dart';

class MainScreenDrawer extends StatefulWidget {
  final ListOfTodosBloc _listOfTodosBloc;

  MainScreenDrawer(this._listOfTodosBloc);

  @override
  State createState() => _MainScreenDrawerState();
}

class _MainScreenDrawerState extends State<MainScreenDrawer> {
  ListOfTodos overdue;
  ListOfTodos today;
  ListOfTodos upcoming;

  int completedTodos;
  int maxTodos;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: <ListOfTodos>[],
      stream: widget._listOfTodosBloc.drawerListsOfTodosStream,
      builder: (context, snapshot) {
        return Drawer(
          child: ListView(
            children: [
              Container(
                height: 120,
                child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: appBarColor,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildProfileImage(),
                        SizedBox(width: 10),
                        _buildUserInfo()
                      ],
                    )),
              ),
              OverdueTodayUpcomingDrawerSection(
                listOfTodosBloc: widget._listOfTodosBloc,
                overdue: overdue.todos.length.toString(),
                today: today.todos.length.toString(),
                upcoming: upcoming.todos.length.toString(),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: ListsDrawerSection(listsOfTodos: snapshot.data, listOfTodosBloc: widget._listOfTodosBloc,),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    List<ListOfTodos> list =
        widget._listOfTodosBloc.filterOverdueAndTodayTodos(false);

    overdue = list[0];
    today = list[1];
    upcoming = widget._listOfTodosBloc.filterUpcomingTodos();

    List<int> completedTasksMaxTasks = widget._listOfTodosBloc.getFinishedTodosMaxTodos();
    completedTodos = completedTasksMaxTasks[0];
    maxTodos = completedTasksMaxTasks[1];
  }

  Column _buildUserInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "${loggedUser.firstName} ${loggedUser.lastName}",
          style: TextStyle(
              fontFamily: "OpenSans", fontSize: 15, color: drawerTextColor),
        ),
        Text(
          "$completedTodos/$maxTodos",
          style: TextStyle(
              fontFamily: "OpenSans", fontSize: 13, color: lightGreyText),
        )
      ],
    );
  }

  ClipOval _buildProfileImage() {
    return ClipOval(
      child: Image.asset(
        'assets/dog_image.jpg',
        width: 70,
        height: 70,
        fit: BoxFit.cover,
      ),
    );
  }
}
