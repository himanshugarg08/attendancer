import 'package:attendancer_final_code/backend/class_attendance_provider.dart';
import 'package:attendancer_final_code/backend/class_data_provider.dart';
import 'package:attendancer_final_code/backend/dashboard_data_provider.dart';
import 'package:attendancer_final_code/configs/app_config.dart';
import 'package:attendancer_final_code/widgets/class_attendance/attendance_page_view.dart';
import 'package:attendancer_final_code/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class ClassAttendance extends StatelessWidget {
  //final String className = "Maths";
  //final int classStrength = 104;
  //final String date = "28-01-2021";
  final scaffoldKey;
  final snackBarText = "Attendance Saved!";

  const ClassAttendance({Key key, this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime pickedDate = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: kIconColor_b),
        backgroundColor: kTransparentColor,
        elevation: 0,
        title: Consumer<ClassAttendanceProvider>(
            builder: (context, attendanceData, child) =>
                MyText(text: attendanceData.date, size: 22.0)),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.getWidth(5),
        ),
        child: Consumer2<ClassDataProvider, ClassAttendanceProvider>(
          builder: (context, classData, attendanceData, child) => Column(
            children: [
              //MyText(text: attendanceData.date, size: 22.0),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                              text: "Class: ${attendanceData.className}",
                              size: 32.0),
                          MyText(
                              text: "Students: ${attendanceData.classStrength}",
                              size: 18.0),
                        ],
                      ),
                    ),
                    attendanceData.classAttendanceList.length != 0
                        ? CircularPercentIndicator(
                            radius: 54.0,
                            lineWidth: 6.0,
                            animation: true,
                            percent: double.parse(
                                attendanceData.classAttendanceList[
                                        attendanceData.pageIndex]
                                    ['attendancepercentage']),
                            animationDuration: 2000,
                            curve: Curves.easeInOutCirc,
                            center: MyText(
                                text:
                                    "${double.parse(attendanceData.classAttendanceList[attendanceData.pageIndex]['attendancepercentage']) * 100}%",
                                size: 12.0),
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: Colors.green,
                          )
                        : SizedBox(),
                  ],
                ),
              ),
              VerticalSpacing(of: 1.0),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(text: "Attendance:", size: 18.0),
                    Consumer<DashBoardDataProvider>(
                      builder: (context, data, child) => GestureDetector(
                        onTap: () async {
                          pickedDate = await showDatePicker(
                            context: context,
                            initialDate: pickedDate,
                            firstDate: DateTime(2021),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null &&
                              pickedDate != DateTime.now()) {
                            print(pickedDate.toString());
                            attendanceData.setDateTo(pickedDate.day.toString() +
                                "-" +
                                pickedDate.month.toString() +
                                "-" +
                                pickedDate.year.toString());
                            attendanceData.getAttendance();
                          }
                        },
                        child: Icon(
                          Icons.date_range,
                          size: 22,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              VerticalSpacing(),
              Expanded(
                child: Container(
                  child: AttendancePageView(),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
