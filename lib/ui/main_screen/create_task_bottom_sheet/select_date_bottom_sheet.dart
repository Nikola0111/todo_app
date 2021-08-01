import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/colors.dart';
import 'package:todo_app/model/values.dart';
import 'package:todo_app/ui/main_screen/create_task_bottom_sheet/calendar_widget_bottom_sheet.dart';

class SelectDateBottomSheet extends StatefulWidget {
  final ValueChanged<DateTime> onDateChanged;

  SelectDateBottomSheet({Key key, this.onDateChanged}) : super(key: key);

  @override
  State createState() => _SelectDateBottomSheetState();
}

class _SelectDateBottomSheetState extends State<SelectDateBottomSheet> {
  bool choosingDate = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Due Date", style: createTaskTitleStyle),
        SizedBox(height: 12),
        choosingDate
            ? CalendarWidgetBottomSheet(
                onDateChanged: (value) => widget.onDateChanged(value))
            : _buildDefaultRow()
      ],
    );
  }

  Row _buildDefaultRow() {
    return Row(
      children: [
        Container(
          width: 200,
          child: TextFormField(
            initialValue: "Today",
            enabled: false,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 4, top: 4, left: 10),
              prefixIcon: Icon(Icons.calendar_today_rounded,
                  color: focusedInputBorder, size: 20),
              hintStyle: TextStyle(
                  fontFamily: "OpenSans", fontSize: 15, color: hintInputColor),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: createTaskBorder, width: 1)),
            ),
            style: TextStyle(
                fontFamily: "OpenSans", fontSize: 15, color: searchButtonColor),
          ),
        ),
        SizedBox(width: 10),
        InkWell(
          onTap: () {
            setState(() {
              choosingDate = true;
            });
          },
          child: Container(
            width: 70,
            height: 40,
            child: Center(
              child: Text(
                "Change",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w600,
                    color: focusedInputBorder,
                    decoration: TextDecoration.underline),
              ),
            ),
          ),
        )
      ],
    );
  }
}
