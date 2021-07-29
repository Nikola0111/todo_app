import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/ui/main_screen/main_screen_appbar.dart';
import 'package:todo_app/ui/main_screen/main_screen_drawer.dart';


class MainScreen extends StatefulWidget {

  @override
  State createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  String _appBarTitle = "Today";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainScreenAppBar(
        title: _appBarTitle,
        openDrawer: null,
        appBar: AppBar(),
      ),
      drawer: MainScreenDrawer(),
      body: Container(
        margin: EdgeInsets.only(left: 28, right: 28, top: 20),
      ),
    );
  }
}