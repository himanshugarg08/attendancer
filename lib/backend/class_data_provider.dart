import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:attendancer_final_code/backend/database_helper.dart';

class ClassDataProvider extends ChangeNotifier {
  String _className = "";
  int _start = 0;
  int _end = 0;
  String _prefix = "";
  String _suffix = "";
  int _classId = 0;

  String get className => _className;
  String get prefix => _prefix;
  String get suffix => _suffix;
  int get start => _start;
  int get end => _end;

  int get classStrength => _end - _start + 1;

  void setClassData(Map<String, dynamic> data) {
    _className = data['classname'];
    _start = data['start'];
    _end = data['end'];
    _prefix = data['prefix'];
    _suffix = data['suffix'];
    _classId = data['id'];
    notifyListeners();
  }

  List _students = [];

  List get studentList => _students;

  void buildStudentIdList() {
    _students =
        List<int>.generate(_end - _start + 1, (int index) => start + index);
  }

  String studentId(int index) {
    return "$_prefix${_students[index]}$_suffix";
  }

  String _selectedDate = "";

  String get date => _selectedDate;

  void setDate() {
    DateTime now = DateTime.now();
    _selectedDate =
        "${now.day.toString()}-${now.month.toString()}-${now.year.toString()}";
  }

  String _classAttendance = "";

  String get classAttendance => _classAttendance;

  // void setClassAttendance(String attendance) {
  //   _classAttendance = attendance;
  //   notifyListeners();
  // }

  void clearAttendance() {
    _classAttendance = "";
    notifyListeners();
  }

  void addAttendance(String studentAttendance) {
    //_classAttendance = "";
    _classAttendance = _classAttendance + studentAttendance;
    notifyListeners();
  }

  void changeAttendance(int index) {
    String change = "";
    if (_classAttendance[index] == "A") {
      change = "P";
    } else {
      change = "A";
    }
    _classAttendance = _classAttendance.substring(0, index) +
        change +
        _classAttendance.substring(index + 1);

    notifyListeners();
  }

  Future<int> saveAttendance() async {
    double count = 0;

    for (int i = 0; i < _classAttendance.length; i++) {
      if (_classAttendance[i] == 'P') {
        count++;
      }
    }

    double percentage = count / _classAttendance.length;

    Map<String, dynamic> row = {
      'date': _selectedDate,
      'attendance': _classAttendance,
      'attendancepercentage': percentage.toString()
    };
    Database db = await DatabaseHelper.instance.database;
    return await db.insert(_className, row);
  }

  bool isListComplete = false;

  void setIsListComplete() {
    isListComplete = !isListComplete;
    notifyListeners();
  }

  Future<void> updateIsDone() async {
    Database db = await DatabaseHelper.instance.database;
    if (_classId != 0) {
      await db.rawQuery('UPDATE classes SET isdone = 1 WHERE id = $_classId');
    }
  }
}
