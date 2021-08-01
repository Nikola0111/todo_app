import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/colors.dart';

class FabOpenBottomSheet extends StatelessWidget {
  final VoidCallback showBottomSheetFunction;

  FabOpenBottomSheet({this.showBottomSheetFunction});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => showBottomSheetFunction(),
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 36,
      ),
      backgroundColor: focusedInputBorder,
    );
  }
}
