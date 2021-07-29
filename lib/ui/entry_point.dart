import 'package:flutter/cupertino.dart';
import 'package:todo_app/bloc/authentication_bloc.dart';
import 'package:todo_app/ui/common/loading_layer.dart';
import 'package:todo_app/ui/login_screen/login_screen.dart';
import 'package:todo_app/ui/main_screen/main_screen.dart';

class EntryPoint extends StatelessWidget {
  final AuthenticationBloc _authenticationBloc = AuthenticationBloc();

  @override
  Widget build(BuildContext context) {
    _authenticationBloc.authenticateMe();

    return StreamBuilder(
      initialData: null,
      stream: _authenticationBloc.userStream,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            if(snapshot.data) {
              return MainScreen();
            }

            return LoginScreen();
          }

          return LoadingLayer();
        },
    );
  }
}