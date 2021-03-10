import 'package:attendancer_final_code/backend/class_data_provider.dart';
import 'package:attendancer_final_code/configs/app_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttendanceList extends StatefulWidget {
  @override
  _AttendanceListState createState() => _AttendanceListState();
}

class _AttendanceListState extends State<AttendanceList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ClassDataProvider>(
      builder: (context, classData, child) => ListView.builder(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: classData.studentList.length,
          itemBuilder: (context, index) {
            return MyListTile(index: index);
          }),
    );
  }
}

class MyListTile extends StatelessWidget {
  final int index;

  const MyListTile({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<ClassDataProvider>(
      builder: (context, classData, child) => GestureDetector(
        onTap: () => classData.changeAttendance(index),
        child: Container(
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
                  classData.studentId(index),
                  style: textStyle(20, FontWeight.w500, kFontColor_b),
                ),
              ),
              CircleAvatar(
                backgroundColor: classData.classAttendance[index] == "P"
                    ? Colors.green
                    : Colors.red,
                child: Text(
                  classData.classAttendance[index],
                  style: textStyle(20, FontWeight.w400, kFontColor),
                ),
                radius: 16.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
