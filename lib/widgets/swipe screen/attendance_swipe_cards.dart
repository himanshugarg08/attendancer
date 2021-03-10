import 'package:attendancer_final_code/backend/class_data_provider.dart';

import 'package:attendancer_final_code/configs/app_config.dart';
import 'package:attendancer_final_code/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AttendanceSwipeCards extends StatefulWidget {
  @override
  _AttendanceSwipeCardsState createState() => _AttendanceSwipeCardsState();
}

class _AttendanceSwipeCardsState extends State<AttendanceSwipeCards> {
  int colorflag = 0;

  DateTime now = new DateTime.now();

  Color cardColor = Colors.white;
  Color iFontColor = kFontColor_b;

  @override
  Widget build(BuildContext context) {
    return Consumer<ClassDataProvider>(
      builder: (context, classData, child) => TinderSwapCard(
        swipeDown: false,
        swipeUp: false,
        stackNum: 3,
        orientation: AmassOrientation.TOP,
        maxWidth: SizeConfig.getWidth(90),
        maxHeight: SizeConfig.getHeight(60),
        minWidth: SizeConfig.getWidth(65),
        minHeight: SizeConfig.getHeight(50),
        cardBuilder: (context, index) => buildCard(index),
        totalNum: classData.studentList.length == null
            ? 0
            : classData.studentList.length,
        swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
          if (align.x < 0) {
            setState(() {
              cardColor = Colors.red;
              iFontColor = kFontColor;
            });
          } else if (align.x > 0) {
            setState(() {
              cardColor = Colors.green;
              iFontColor = kFontColor;
            });
          }
        },
        swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
          if (orientation == CardSwipeOrientation.LEFT) {
            classData.addAttendance("A");

            cardColor = Colors.white;
            iFontColor = kFontColor_b;
          } else if (orientation == CardSwipeOrientation.RIGHT) {
            classData.addAttendance("P");

            cardColor = Colors.white;
            iFontColor = kFontColor_b;
          }
          if (orientation == CardSwipeOrientation.RECOVER) {
            setState(() {
              cardColor = Colors.white;
              iFontColor = kFontColor_b;
            });
          }
          if (index == classData.studentList.length - 1) {
            classData.isListComplete = true;
          }
        },
      ),
    );
  }

  Widget buildCard(int index) {
    return Consumer<ClassDataProvider>(
      builder: (context, classData, child) => Card(
        elevation: 4.0,
        color: cardColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.user,
              size: 100,
              color: iFontColor,
            ),
            VerticalSpacing(of: 4),
            Text(
              classData.studentId(index),
              style: textStyle(32, FontWeight.w500, iFontColor),
            ),
            VerticalSpacing(of: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.arrowCircleLeft,
                        size: 40,
                        color: iFontColor,
                      ),
                      VerticalSpacing(
                        of: 1,
                      ),
                      MyText(
                        text: "Absent",
                        size: 16,
                        weight: FontWeight.normal,
                        color: iFontColor,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.arrowCircleRight,
                        size: 40,
                        color: iFontColor,
                      ),
                      VerticalSpacing(
                        of: 1,
                      ),
                      MyText(
                        text: "Present",
                        size: 16,
                        weight: FontWeight.normal,
                        color: iFontColor,
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
