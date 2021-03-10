import 'package:attendancer_final_code/backend/dashboard_data_provider.dart';
import 'package:attendancer_final_code/configs/app_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttendanceProgressBar extends StatelessWidget {
  Widget buildAttendanceProgress(
      BuildContext context, Color color, double width) {
    return AnimatedContainer(
      curve: Curves.easeInOutCirc,
      constraints: BoxConstraints(
        minWidth: 0.0,
        maxWidth: double.infinity,
        minHeight: 0.0,
        maxHeight: double.infinity,
      ),
      duration: Duration(seconds: 2),
      margin: EdgeInsets.symmetric(vertical: SizeConfig.getHeight(2.0)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: color,
      ),
      height: 10,
      width: SizeConfig.getWidth(100.0) * width,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      buildAttendanceProgress(context, Colors.red[500], 0.85),
      Consumer<DashBoardDataProvider>(
        builder: (context, data, child) => buildAttendanceProgress(
          context,
          Colors.green[500],
          (0.85 * data.getWidth()),
        ),
      )
    ]);
  }
}
