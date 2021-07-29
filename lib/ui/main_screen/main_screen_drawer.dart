import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/colors.dart';

class MainScreenDrawer extends StatefulWidget {
  @override
  State createState() => _MainScreenDrawerState();
}

class _MainScreenDrawerState extends State<MainScreenDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 120,
            child: DrawerHeader(
                decoration: BoxDecoration(
                  color: appBarColor,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildProfileImage(),
                    SizedBox(width: 10),
                    _buildUserInfo()
                  ],
                )),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: appBarColor, width: 1)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
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
                ),
                InkWell(
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
                ),
                InkWell(
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Column _buildUserInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Nikola Milosevic",
          style: TextStyle(
              fontFamily: "OpenSans", fontSize: 15, color: drawerTextColor),
        ),
        Text(
          "0/5 tasks done",
          style: TextStyle(
              fontFamily: "OpenSans", fontSize: 13, color: lightGreyText),
        )
      ],
    );
  }

  ClipOval _buildProfileImage() {
    return ClipOval(
      child: Image.asset(
        'assets/dog_image.jpg',
        width: 70,
        height: 70,
        fit: BoxFit.cover,
      ),
    );
  }
}
