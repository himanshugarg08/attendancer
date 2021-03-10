import 'package:attendancer_final_code/backend/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class ClassAttendanceProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _classAttendanceList = [];
  static final _columnDate = 'date';
  //static final _columnAttendance = 'attendance';
  String _className = "";
  String _selectedDate = "";

  int _start = 0;
  int _end = 0;
  String _prefix = "";
  String _suffix = "";

  String get className => _className;
  String get prefix => _prefix;
  String get suffix => _suffix;
  int get start => _start;
  int get end => _end;

  int get classStrength => _end - _start + 1;

  List<Map<String, dynamic>> get classAttendanceList => _classAttendanceList;

  String get date => _selectedDate;

  void setDate() {
    DateTime now = DateTime.now();
    _selectedDate =
        "${now.day.toString()}-${now.month.toString()}-${now.year.toString()}";
  }

  void setDateTo(String date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setClassData(Map<String, dynamic> data) {
    _className = data['classname'];
    _start = data['start'];
    _end = data['end'];
    _prefix = data['prefix'];
    _suffix = data['suffix'];
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

  Future<List<Map<String, dynamic>>> getAttendanceByDate() async {
    Database db = await DatabaseHelper.instance.database;
    _classAttendanceList = await db.rawQuery(
        'SELECT * FROM $_className WHERE $_columnDate = "$_selectedDate" ORDER BY id DESC');
    if (_classAttendanceList.length == 0) {
      var v = await db
          .rawQuery('SELECT * FROM $_className ORDER BY id DESC LIMIT 1');
      if (v.length != 0) {
        setDateTo(v[0]['date']);
        notifyListeners();
        getAttendanceByDate();
      } else {
        return _classAttendanceList;
      }
    }
    notifyListeners();

    return _classAttendanceList;
  }

  static final _columnIdForAttendance = 'id';

  Future<void> getAttendance() async {
    Database db = await DatabaseHelper.instance.database;
    _classAttendanceList = await db.rawQuery(
        'SELECT * FROM $_className WHERE $_columnDate = "$_selectedDate" ORDER BY $_columnIdForAttendance DESC');
    if (_classAttendanceList.length == 0) {
      _classAttendanceList = [];

      notifyListeners();
    } else {
      notifyListeners();
    }
  }

  int _pageIndex = 0;

  int get pageIndex => _pageIndex;

  void setIndexTo(int index) {
    _pageIndex = index;
    notifyListeners();
  }
}
