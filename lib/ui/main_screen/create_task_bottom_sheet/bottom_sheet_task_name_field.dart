import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/colors.dart';

class BottomSheetTaskNameField extends StatefulWidget {
  final ValueChanged<String> onTaskNameChanged;

  BottomSheetTaskNameField({Key key, this.onTaskNameChanged}) : super(key: key);

  @override
  State createState() => _BottomSheetTaskNameFieldState();
}

class _BottomSheetTaskNameFieldState extends State<BottomSheetTaskNameField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Task Name",
          style: TextStyle(
              color: darkText,
              fontWeight: FontWeight.w600,
              fontFamily: "OpenSans",
              fontSize: 15),
        ),
        TextFormField(
          onChanged: (value) => widget.onTaskNameChanged(value),
          decoration: InputDecoration(
            hintText: "Enter your email",
            hintStyle: TextStyle(
                fontFamily: "OpenSans", fontSize: 15, color: hintInputColor),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: enabledInputBorder, width: 1)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: focusedInputBorder, width: 1)),
            errorStyle: TextStyle(
                color: errorTextColor, fontFamily: "OpenSans", fontSize: 12),
          ),
          style:
              TextStyle(fontFamily: "OpenSans", fontSize: 15, color: darkText),
        ),
        Container(
          margin: EdgeInsets.only(top: 4),
          child: Text("Hint: Task name should be 4 letters long",
              style: TextStyle(
                  color: lightGreyText, fontSize: 11, fontFamily: "OpenSans")),
        ),
      ],
    );
  }
}
