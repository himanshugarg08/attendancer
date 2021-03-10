import 'package:attendancer_final_code/backend/class_attendance_provider.dart';
import 'package:attendancer_final_code/widgets/class_attendance/attendance_page_list.dart';
import 'package:attendancer_final_code/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttendancePageView extends StatelessWidget {
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ClassAttendanceProvider>(
        builder: (context, attendanceData, child) {
          if (attendanceData.classAttendanceList.length != 0) {
            return buildPageView(attendanceData);
          } else {
            return Center(
                child: MyText(text: "No Attendance Record", size: 20));
          }
        },
      ),
    );
  }

  Widget buildPageView(ClassAttendanceProvider attendanceData) {
    return PageView.builder(
        controller: pageController,
        onPageChanged: (index) {
          attendanceData.setIndexTo(index);
        },
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemCount: attendanceData.classAttendanceList.length,
        itemBuilder: (context, index) {
          return AttendancePageList(
            classAttendance: attendanceData.classAttendanceList[index]
                ['attendance'],
          );
        });
  }
}
