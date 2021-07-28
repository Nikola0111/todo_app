import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/colors.dart';

class LoginScreenTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "SIGN IN TO",
            style: TextStyle(
                color: lightGreyText, fontSize: 14, fontFamily: "OpenSans"),
          ),
          Text(
            "To-Do list",
            style: TextStyle(
                color: darkText,
                fontSize: 30,
                fontFamily: "OpenSans",
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
