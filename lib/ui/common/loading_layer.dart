import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todo_app/model/colors.dart';


class LoadingLayer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          child: Center(
              child: SpinKitRing(color: focusedInputBorder)
          )
      ),
    );
  }
}
