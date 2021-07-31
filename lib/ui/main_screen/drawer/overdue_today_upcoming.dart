import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/colors.dart';

class OverdueTodayUpcomingDrawerSection extends StatelessWidget {
  final String overdue;
  final String today;
  final String upcoming;
  const OverdueTodayUpcomingDrawerSection({
    this.overdue,
    this.today,
    this.upcoming,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: appBarColor, width: 1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOverdue(),
          _buildToday(),
          _buildUpcoming()
        ],
      ),
    );
  }

  InkWell _buildUpcoming() {
    return InkWell(
          onTap: () {},
          child: SizedBox(
            height: 40,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Icon(
                    Icons.calendar_today_outlined,
                    color: lightGreyText,
                    size: 20,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    "Upcoming",
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 15,
                        color: searchButtonColor),
                  ),
                ),
                Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      alignment: Alignment.centerRight,
                      child: Text(
                        "3",
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.w600,
                            color: lightGreyText),
                      ),
                    )
                )
              ],
            ),
          ),
        );
  }

  InkWell _buildToday() {
    return InkWell(
          onTap: () {},
          child: SizedBox(
            height: 40,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Icon(
                    Icons.today,
                    color: focusedInputBorder,
                    size: 20,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    "Today",
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 15,
                        color: searchButtonColor),
                  ),
                ),
                Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      alignment: Alignment.centerRight,
                      child: Text(
                        "3",
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.w600,
                            color: lightGreyText),
                      ),
                    )
                )
              ],
            ),
          ),
        );
  }

  InkWell _buildOverdue() {
    return InkWell(
          child: SizedBox(
            height: 40,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Icon(
                    Icons.warning_amber_outlined,
                    color: errorTextColor,
                    size: 20,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    "Overdue",
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 15,
                        color: searchButtonColor),
                  ),
                ),
                Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      alignment: Alignment.centerRight,
                      child: Text(
                        "2",
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.w600,
                            color: lightGreyText),
                      ),
                    )
                )
              ],
            ),
          ),
          onTap: () {},
        );
  }
}
