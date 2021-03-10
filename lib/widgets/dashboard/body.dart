import 'package:attendancer_final_code/backend/dashboard_data_provider.dart';
import 'package:attendancer_final_code/configs/app_config.dart';
import 'package:attendancer_final_code/screens/add_class.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'attendance_progress_bar.dart';
import 'class_list.dart';
import '../my_text.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VerticalSpacing(
            of: 5,
          ),
          MyText(text: "Good Morning,", size: 22, weight: FontWeight.w500),
          Consumer<DashBoardDataProvider>(
            builder: (context, data, child) =>
                MyText(text: data.name, size: 38, weight: FontWeight.w500),
          ),
          VerticalSpacing(),
          Consumer<DashBoardDataProvider>(
            builder: (context, data, child) => data.isNewUser != 0
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                          text: "Today's Attendance:",
                          size: 18,
                          weight: FontWeight.w400),
                      AttendanceProgressBar(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                              text: "${data.doneClasses} Done",
                              size: 14,
                              weight: FontWeight.w400),
                          MyText(
                              text:
                                  "${data.totalClasses - data.doneClasses} Remaining",
                              size: 14,
                              weight: FontWeight.w400)
                        ],
                      ),
                    ],
                  )
                : SizedBox(),
          ),
          VerticalSpacing(of: 1.5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(text: "Classes:", size: 22, weight: FontWeight.w400),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AddClass();
                      }));
                    },
                    child:
                        MyText(text: "+", size: 24, weight: FontWeight.w400)),
              ],
            ),
          ),
          VerticalSpacing(of: 2),
          Expanded(child: Container(child: ClassList())),
        ],
      ),
    );
  }
}
