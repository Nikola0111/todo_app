import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/bloc/list_of_todos_bloc.dart';
import 'package:todo_app/model/colors.dart';
import 'package:todo_app/model/list_of_todos.dart';
import 'package:todo_app/services/list_of_todos_service.dart';
import 'package:todo_app/ui/common/error_dialog.dart';
import 'package:todo_app/ui/main_screen/drawer/drawer_lists_section/add_list_dialog.dart';
import 'package:todo_app/ui/main_screen/drawer/drawer_lists_section/drawer_lists_list_item.dart';

class ListsDrawerSection extends StatefulWidget {
  final List<ListOfTodos> listsOfTodos;
  final ListOfTodosBloc listOfTodosBloc;

  const ListsDrawerSection({
    this.listsOfTodos,
    this.listOfTodosBloc,
    Key key,
  }) : super(key: key);

  @override
  _ListsDrawerSectionState createState() => _ListsDrawerSectionState();
}

class _ListsDrawerSectionState extends State<ListsDrawerSection> {
  final ListOfTodosService _service = ListOfTodosService();
  bool _isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [_buildListViewHeader(), SizedBox(height: 5), _buildListView()],
    );
  }

  Container _buildListViewHeader() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
              child: Text(
            "Lists",
            style: TextStyle(
                fontFamily: "OpenSans",
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: searchButtonColor),
          )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: InkWell(
              onTap: () {
                setState(() {
                  _isCollapsed = !_isCollapsed;
                });
              },
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Icon(
                    _isCollapsed
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                    color: darkText,
                    size: 20),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AddEditListDialog(
                      saveFunction: _addNewListToListOfLists));
            },
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Icon(Icons.add, color: darkText, size: 20),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListView() {
    return _isCollapsed
        ? Container()
        : ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: widget.listsOfTodos.length,
            itemBuilder: (context, index) => DrawerListsListItem(
              listOfTodos: widget.listsOfTodos[index],
              editButtonFunction: _editItemInList,
              listDetailsFunction:
                  widget.listOfTodosBloc.previewTodosOfSpecificList,
            ),
          );
  }

  _editItemInList(ListOfTodos listOfTodos) async {
    ListOfTodos ret = await _service.updateListName(listOfTodos);

    if (ret == null) {
      showServerErrorDialog();
      return;
    }
    if (ret.name == null) {
      showListAlreadyExistsDialog();
      return;
    }

    for (int i = 0; i < widget.listsOfTodos.length; i++) {
      if (widget.listsOfTodos[i].id == ret.id) {
        setState(() {
          widget.listsOfTodos[i] = ret;
        });
      }
    }
  }

  _addNewListToListOfLists(ListOfTodos listOfTodos) async {
    ListOfTodos ret = await _service.createList(listOfTodos);

    if (ret.name == null) {
      showListAlreadyExistsDialog();
      return;
    }

    setState(() {
      widget.listsOfTodos.add(ret);
    });
  }

  showListAlreadyExistsDialog() {
    return showDialog(
        context: context,
        builder: (context) => ErrorDialog("Name of list already exists"));
  }

  showServerErrorDialog() {
    return showDialog(
        context: context,
        builder: (context) =>
            ErrorDialog("Server error! Please try again later."));
  }
}
