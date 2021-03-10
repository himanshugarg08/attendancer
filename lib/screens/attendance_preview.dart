import 'package:attendancer_final_code/backend/class_data_provider.dart';
import 'package:attendancer_final_code/configs/app_config.dart';
import 'package:attendancer_final_code/screens/dashboard.dart';
import 'package:attendancer_final_code/widgets/attendance_preview/attendance_list.dart';
import 'package:attendancer_final_code/widgets/my_button.dart';
import 'package:attendancer_final_code/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttendancePreview extends StatelessWidget {
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kIconColor_b),
        backgroundColor: kTransparentColor,
        elevation: 0,
        title: Consumer<ClassDataProvider>(
            builder: (context, classData, child) =>
                MyText(text: "Class: ${classData.className}", size: 36.0)),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Consumer<ClassDataProvider>(
        builder: (context, classData, child) => Container(
          margin: EdgeInsets.symmetric(
            horizontal: SizeConfig.getWidth(5),
          ),
          child: Column(
            children: [
              //MyText(text: "Class: ${classData.className}", size: 36.0),
              MyText(
                  text: "Students: ${classData.end - classData.start + 1}",
                  size: 18.0),
              VerticalSpacing(of: 4.0),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(text: "Edit Attendance:", size: 18.0),
                    MyText(text: classData.date, size: 18.0),
                  ],
                ),
              ),
              VerticalSpacing(),
              Expanded(
                  child: Container(
                child: AttendanceList(),
              )),
              VerticalSpacing(),
              GestureDetector(
                onTap: () async {
                  int attendanceId = await classData.saveAttendance();
                  classData.updateIsDone();
                  classData.setIsListComplete();
                  if (attendanceId != null) {
                    print(attendanceId);
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) {
                      return DashBoard();
                    }), (route) => false);
                  }
                },
                child: MyButton(
                  displayText: "Save",
                  size: 40.0,
                ),
              ),
              VerticalSpacing()
            ],
          ),
        ),
      )),
    );
  }
}
