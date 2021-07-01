import 'package:attendancer_final_code/backend/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class DashBoardDataProvider extends ChangeNotifier {
  List<Map<String, dynamic>> user = [];
  bool isAlreadyOpened = false;

  String _name = "";

  int doneClasses = 0;
  int totalClasses = 0;

  String _startDate = "";

  String get startDate => _startDate;
  String get name => _name;
  int get isNewUser => totalClasses;

  Future<void> checkForUser() async {
    Database db = await DatabaseHelper.instance.database;
    user = await db.rawQuery('SELECT * FROM userdata');
    if (user.length != 0) {
      print(user);
      textToDisplay(user[0]['FirstName'], user[0]['LastName']);
      setStartDate(user[0]['StartDate']);
      compareDate(user[0]['LastDate']);
      return true;
    } else {
      return false;
    }
  }

  void textToDisplay(String firstName, String lastName) {
    String text = "$firstName $lastName";

    if (text.length > 14) {
      text = firstName;
      _name = text;
    }
    _name = text;
    notifyListeners();
  }

  void setStartDate(String date) {
    _startDate = date;
    notifyListeners();
  }

  void compareDate(String date) async {
    String currentDate = DateTime.now().day.toString();
    if (date == currentDate) {
      //isAlreadyOpened = true;
      print("lastDate == currentDate");
      print(date);
      print(currentDate);
    } else {
      Database db = await DatabaseHelper.instance.database;
      await db.rawQuery('UPDATE classes SET isdone = 0');
      await db.rawQuery('UPDATE userdata SET LastDate = $currentDate');
    }
  }

  void getTotalClasses() async {
    List<Map<String, dynamic>> classes;
    Database db = await DatabaseHelper.instance.database;
    classes = await db.rawQuery('SELECT * from classes');
    totalClasses = classes.length;
    notifyListeners();
  }

  void getDoneClasses() async {
    List<Map<String, dynamic>> classes;
    Database db = await DatabaseHelper.instance.database;
    classes = await db.rawQuery('SELECT * from classes WHERE isdone = 1');
    doneClasses = classes.length;
    notifyListeners();
  }

  double getWidth() {
    if (totalClasses == 0) {
      return 0.0;
    } else {
      return doneClasses.toDouble() / totalClasses.toDouble();
    }
  }
}
