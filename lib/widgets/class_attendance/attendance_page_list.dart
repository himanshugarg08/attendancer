import 'package:attendancer_final_code/backend/class_attendance_provider.dart';
import 'package:attendancer_final_code/configs/app_config.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttendancePageList extends StatefulWidget {
  final String classAttendance;

  const AttendancePageList({Key key, this.classAttendance}) : super(key: key);
  @override
  _AttendancePageListState createState() => _AttendancePageListState();
}

class _AttendancePageListState extends State<AttendancePageList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ClassAttendanceProvider>(
      builder: (context, attendanceData, child) => ListView.builder(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: attendanceData.studentList.length,
          itemBuilder: (context, index) {
            return MyListTile(
              index: index,
              attendanceData: attendanceData,
              classAttendance: widget.classAttendance,
            );
          }),
    );
  }
}

class MyListTile extends StatelessWidget {
  final ClassAttendanceProvider attendanceData;
  final int index;
  final String classAttendance;

  const MyListTile(
      {Key key, this.index, this.attendanceData, this.classAttendance})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.getWidth(1),
          vertical: SizeConfig.getHeight(1.5)),
      child: Row(
        children: [
          Icon(
            Icons.account_circle,
            color: kIconColor_b,
            size: 32,
          ),
          SizedBox(
            width: SizeConfig.getWidth(2.5),
          ),
          Expanded(
            child: Text(
              attendanceData.studentId(index),
              style: textStyle(20, FontWeight.w500, kFontColor_b),
            ),
          ),
          CircleAvatar(
            backgroundColor:
                classAttendance[index] == "P" ? Colors.green : Colors.red,
            child: Text(
              classAttendance[index],
              style: textStyle(20, FontWeight.w400, kFontColor),
            ),
            radius: 16.0,
          )
        ],
      ),
    );
  }
}
