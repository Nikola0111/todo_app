import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/colors.dart';

class MainScreenAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Function openDrawer;
  final AppBar appBar;

  const MainScreenAppBar({Key key, this.title, this.openDrawer, this.appBar})
      : super(key: key);

  @override
  State createState() => _MainScreenAppBarState();

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}

class _MainScreenAppBarState extends State<MainScreenAppBar> {
  bool showSearch = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appBarColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: darkText,
      ),
      title: Text(widget.title,
          style: TextStyle(
              color: darkText,
              fontFamily: "OpenSans",
              fontSize: 20,
              fontWeight: FontWeight.bold)),
      actions: [
        IconButton(
            icon: Icon(Icons.search),
            color: searchButtonColor,
            iconSize: 30,
            onPressed: null)
      ],
    );
  }
}
