import 'package:flutter/cupertino.dart';
import 'package:todo_app/model/user.dart';

import 'colors.dart';

String accessToken;
User loggedUser;

final String baseUrl = "https://api-flutter-task.madduckcode.com/api/v1/";

final TextStyle createTaskTitleStyle = TextStyle(
    color: darkText,
    fontWeight: FontWeight.w600,
    fontFamily: "OpenSans",
    fontSize: 15);
