import 'package:flutter/cupertino.dart';
import 'package:todo_app/ui/main_screen/create_task_bottom_sheet/bottom_sheet_task_name_field.dart';

class CreateTaskBottomSheet extends StatefulWidget {
  @override
  State createState() => _CreateTaskBottomSheetState();
}

class _CreateTaskBottomSheetState extends State<CreateTaskBottomSheet> {
  String taskName;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetTaskNameField(
              onTaskNameChanged: (value) => taskName = value),
        ],
      ),
    );
  }
}
