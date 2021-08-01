import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:todo_app/model/colors.dart';

class CalendarWidgetBottomSheet extends StatefulWidget {
  final ValueChanged<DateTime> onDateChanged;

  CalendarWidgetBottomSheet({Key key, this.onDateChanged}) : super(key: key);

  @override
  State createState() => _CalendarWidgetBottomSheetState();
}

class _CalendarWidgetBottomSheetState extends State<CalendarWidgetBottomSheet> {
  DateTime selectedDate = DateTime.now();


  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime comparingMonth = DateTime(now.year, now.month, now.day);

    return CalendarCarousel(
      height: 360,
      selectedDateTime: selectedDate,
      todayButtonColor: Colors.transparent,
      todayBorderColor: Colors.transparent,
      selectedDayButtonColor: Colors.transparent,
      selectedDayBorderColor: Colors.transparent,
      weekdayTextStyle: TextStyle(color: drawerTextColor, fontFamily: "OpenSans", fontSize: 12),
      headerTextStyle: TextStyle(color: drawerTextColor, fontFamily: "OpenSans", fontSize: 16),
      iconColor: drawerTextColor,
      customDayBuilder: (
          bool isSelectable,
          int index,
          bool isSelectedDay,
          bool isToday,
          bool isPrevMonthDay,
          TextStyle textStyle,
          bool isNextMonthDay,
          bool isThisMonthDay,
          DateTime day,
          ) {
        if(comparingMonth.isAfter(day) || isNextMonthDay || isPrevMonthDay) {
          return _disabledDate(day);
        }

        if(isSelectedDay) {
          return _selectedDate(day);
        }

        if(!comparingMonth.isAfter(day)) {
          return _enabledDate(day);
        }


        return Container();
      },
      onDayPressed: (DateTime date, List<String> events) {
        widget.onDateChanged(date);
        setState(() {
          selectedDate = date;
        });
      },
    );
  }

  Widget _disabledDate(DateTime day) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Container(
        margin: EdgeInsets.only(top: 2, left: 1),
        alignment: Alignment.center,
        child: Text(
            "${day.day}",
            style: TextStyle(color: hintInputColor ,fontFamily: "OpenSans", fontSize: 16)),
      ),
    );
  }

  Widget _enabledDate(DateTime day) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Container(
        margin: EdgeInsets.only(top: 2, left: 1),
        alignment: Alignment.center,
        child: Text(
            "${day.day}",
            style: TextStyle(color: drawerTextColor ,fontFamily: "OpenSans", fontSize: 16)),
      ),
    );
  }

  Widget _selectedDate(DateTime day) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          color: focusedInputBorder,
          shape: BoxShape.circle
      ),
      child: Container(
        margin: EdgeInsets.only(top: 2, left: 1),
        alignment: Alignment.center,

        child: Text(
            "${day.day}",
            style: TextStyle(color: white ,fontFamily: "OpenSans", fontSize: 16)),
      ),
    );
  }
}