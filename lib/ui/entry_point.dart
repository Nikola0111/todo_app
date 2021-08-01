import 'package:flutter/cupertino.dart';
import 'package:todo_app/ui/login_screen/login_screen.dart';

class EntryPoint extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return LoginScreen();

    // return StreamBuilder(
    //   initialData: null,
    //   stream: _authenticationBloc.userStream,
    //     builder: (context, snapshot) {
    //       if(snapshot.hasData) {
    //         if(snapshot.data) {
    //           return MainScreen();
    //         }
    //
    //         return LoginScreen();
    //       }
    //
    //       return LoadingLayer();
    //     },
    // );
  }
}