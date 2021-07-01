import 'package:attendancer_final_code/backend/class_data_provider.dart';
import 'package:attendancer_final_code/configs/app_config.dart';
import 'package:attendancer_final_code/configs/utils.dart';
import 'package:attendancer_final_code/screens/attendance_preview.dart';
import 'package:attendancer_final_code/screens/dashboard.dart';
import 'package:attendancer_final_code/widgets/swipe%20screen/attendance_swipe_cards.dart';
import 'package:attendancer_final_code/widgets/my_button.dart';
import 'package:attendancer_final_code/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SwipeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: kIconColor_b),
        backgroundColor: kTransparentColor,
        elevation: 0,
      ),
      body: SafeArea(
          child: Consumer<ClassDataProvider>(
        builder: (context, classData, child) => Container(
          margin: EdgeInsets.symmetric(
            horizontal: SizeConfig.getWidth(7),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                    text: Utils().getStringWithSpace(classData.className),
                    size: 48,
                    weight: FontWeight.w500),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: MyText(
                      text: "Students: ${classData.end - classData.start + 1}",
                      size: 20,
                      weight: FontWeight.w500),
                ),
                VerticalSpacing(of: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: MyText(
                      text: "Quick Attendance:",
                      size: 22,
                      weight: FontWeight.w500),
                ),
                VerticalSpacing(),
                Container(
                  height: SizeConfig.getHeight(60),
                  width: SizeConfig.getWidth(100),
                  child: AttendanceSwipeCards(),
                ),
                VerticalSpacing(),
                GestureDetector(
                    onTap: () {
                      if (classData.isListComplete) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return AttendancePreview();
                        }));
                      } else {
                        showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Row(
                                  children: [
                                    Icon(Icons.warning),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text('Warning'),
                                  ],
                                ),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text(
                                          'Attendance is not completed yet. Do you really want to end this attendance?'),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('End'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return DashBoard();
                                      }));
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      }
                    },
                    child: MyButton(
                      displayText: "End",
                      size: 40.0,
                    ))
              ],
            ),
          ),
        ),
      )),
    );
  }
}
