import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/bloc/authentication_bloc.dart';
import 'package:todo_app/model/colors.dart';

class LoginFieldPassword extends StatefulWidget {
  final AuthenticationBloc _authenticationBloc;

  LoginFieldPassword(this._authenticationBloc);

  @override
  State createState() => _LoginFieldPasswordState();
}

class _LoginFieldPasswordState extends State<LoginFieldPassword> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget._authenticationBloc.passwordStream,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Password",
              style: TextStyle(
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w600,
                  color: darkText),
            ),
            SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hintText: "Enter your password",
                  errorText: snapshot.error,
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
                    borderSide: BorderSide(color: focusedInputBorder, width: 1),
                  ),
                  errorBorder: _errorBorder(),
                  focusedErrorBorder: _errorBorder(),
                  suffixIcon: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: SvgPicture.asset(
                        _obscureText
                            ? "assets/ic_password_show.svg"
                            : "assets/ic_password_hide.svg",
                      ),
                    ),
                  ),
                  suffixIconConstraints: BoxConstraints(
                      minWidth: 40,
                      maxWidth: 50,
                      minHeight: 40,
                      maxHeight: 50)),
              style:
              TextStyle(fontFamily: "OpenSans", fontSize: 15, color: darkText),
              obscureText: _obscureText,
              onChanged: (value) =>
                  widget._authenticationBloc.changePassword(value),
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
