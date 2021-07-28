import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/bloc/authentication_bloc.dart';
import 'package:todo_app/model/colors.dart';

class LoginFieldEmail extends StatelessWidget {
  final AuthenticationBloc _authenticationBloc;

  LoginFieldEmail(this._authenticationBloc);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _authenticationBloc.emailStream,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Email",
              style: TextStyle(
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w600,
                  color: darkText),
            ),
            SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                errorText: snapshot.error,
                hintText: "Enter your email",
                hintStyle: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 15,
                    color: hintInputColor),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: enabledInputBorder, width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: focusedInputBorder, width: 1)),
                errorBorder: _errorBorder(),
                focusedErrorBorder: _errorBorder(),
                errorStyle: TextStyle(
                    color: errorTextColor,
                    fontFamily: "OpenSans",
                    fontSize: 12),
              ),
              style: TextStyle(
                  fontFamily: "OpenSans", fontSize: 15, color: darkText),
              onChanged: (value) => _authenticationBloc.changeEmail(value),
            )
          ],
        );
      },
    );
  }

  OutlineInputBorder _errorBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: errorTextColor, width: 1));
  }
}
