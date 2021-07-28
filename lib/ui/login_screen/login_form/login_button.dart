import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/model/colors.dart';

class LoginButton extends StatelessWidget {
  final Function _loginFunction;

  LoginButton(this._loginFunction);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.tightFor(height: 60, width: double.infinity),
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(focusedInputBorder),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ))),
          onPressed: _loginFunction,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign in",
                style: TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16),
              ),
              SizedBox(
                width: 10,
              ),
              SvgPicture.asset(
                "assets/ic_arrow_right.svg",
                height: 12,
                width: 12,
              )
            ],
          )),
    );
  }
}
