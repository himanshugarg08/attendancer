import 'package:attendancer_final_code/backend/class_attendance_provider.dart';
import 'package:attendancer_final_code/backend/class_data_provider.dart';
import 'package:attendancer_final_code/backend/dashboard_data_provider.dart';
import 'package:attendancer_final_code/backend/data_provider.dart';
import 'package:attendancer_final_code/configs/app_config.dart';
import 'package:attendancer_final_code/screens/dashboard.dart';
import 'package:attendancer_final_code/screens/user_name_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<BackEnd>(
      create: (context) => BackEnd(),
    ),
    ChangeNotifierProvider<ClassDataProvider>(
      create: (context) => ClassDataProvider(),
    ),
    ChangeNotifierProvider<ClassAttendanceProvider>(
      create: (context) => ClassAttendanceProvider(),
    ),
    ChangeNotifierProvider<DashBoardDataProvider>(
      create: (context) => DashBoardDataProvider(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendancer',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future _myFuture;

  @override
  void initState() {
    _myFuture = Provider.of<DashBoardDataProvider>(context, listen: false)
        .checkForUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _myFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data) {
            return DashBoard();
          } else {
            return UserNameInput();
          }
        } else {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: color5,
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
