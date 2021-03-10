import 'package:attendancer_final_code/backend/class_attendance_provider.dart';
import 'package:attendancer_final_code/backend/class_data_provider.dart';
import 'package:attendancer_final_code/backend/dashboard_data_provider.dart';
import 'package:attendancer_final_code/configs/app_config.dart';
import 'package:attendancer_final_code/widgets/dashboard/body.dart';
//import 'package:attendancer_final_code/widgets/my_app_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    Provider.of<ClassDataProvider>(context, listen: false).setDate();
    Provider.of<ClassAttendanceProvider>(context, listen: false).setDate();
    Provider.of<DashBoardDataProvider>(context, listen: false).getDoneClasses();
    Provider.of<DashBoardDataProvider>(context, listen: false)
        .getTotalClasses();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: kTransparentColor,
        //   elevation: 0,
        // ),
        body: SafeArea(
      child: Body(),
    ));
  }
}
