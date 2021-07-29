import 'package:flutter/material.dart';
import 'package:todo_app/ui/entry_point.dart';
import 'package:todo_app/ui/login_screen/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: EntryPoint(),
      ),
    );
  }
}