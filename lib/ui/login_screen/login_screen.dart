import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/bloc/authentication_bloc.dart';
import 'package:todo_app/model/colors.dart';
import 'package:todo_app/model/static_strings.dart';
import 'package:todo_app/ui/login_screen/login_form/login_button.dart';

import 'login_form/login_field_password.dart';
import 'login_form/login_field_email.dart';
import 'login_screen_title.dart';

class LoginScreen extends StatefulWidget {
  @override
  State createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthenticationBloc _authenticationBloc = AuthenticationBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 30, right: 30, top: 120, bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LoginScreenTitle(),
              SizedBox(height: 40),
              LoginFieldEmail(_authenticationBloc),
              SizedBox(height: 20),
              LoginFieldPassword(_authenticationBloc),
              SizedBox(height: 40),
              LoginButton(_loginFunction),
            ],
          ),
        ),
      ),
    );
  }

  _loginFunction() async{
    FocusScope.of(context).requestFocus();
    String ret = await _authenticationBloc.performLogin();

    if(ret == invalidCredentials)
      _showErrorStreamDialog(context, "Invalid credentials");
  }

  _showErrorStreamDialog(BuildContext context, String content) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                "Error",
                style: TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.bold,
                    color: darkText),
              ),
              content: Container(
                child: Text(content,
                    style: TextStyle(fontFamily: "OpenSans", color: darkText)),
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("Close",
                        style:
                            TextStyle(fontFamily: "OpenSans", color: darkText)))
              ],
            ));
  }

  @override
  void dispose() {
    _authenticationBloc.dispose();
    super.dispose();
  }
}
