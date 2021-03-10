import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static final _dbName = "attendancer.db";
  static final _dbVersion = 1;
  static final _tableName = 'classes';
  static final _tableTwoName = 'userdata';

  static final _columnId = 'id';
  static final _columnClassName = 'classname';
  static final _columnStartOfId = 'start';
  static final _columnEndOfId = 'end';
  static final _columnPrefixOfId = 'prefix';
  static final _columnSuffixOfId = 'suffix';
  static final _columnisDone = 'isdone';

  static final _columnIdForAttendance = 'id';
  static final _columnDate = 'date';
  static final _columnAttendance = 'attendance';
  static final _columnAttendancePercentage = 'attendancepercentage';

  static final _columnIdForUser = 'id';
  static final _columnFirstName = 'FirstName';
  static final _columnLastName = 'LastName';
  static final _columnStartDate = 'StartDate';
  static final _columnLastDate = 'LastDate';
  static final _columnDarkMode = 'DarkMode';

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initiatedatabase();
    return _database;
  }

  _initiatedatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _oncreate);
  }

  Future<void> _oncreate(Database db, int version) async {
    await db.execute("""
    CREATE TABLE $_tableName ($_columnIdForUser INTEGER PRIMARY KEY,
    $_columnClassName  text not null,
    $_columnStartOfId  integer not null,
    $_columnEndOfId  integer not null,
    $_columnPrefixOfId  text,
    $_columnSuffixOfId text,
    $_columnisDone int not null)
    """);

    await db.execute("""
    CREATE TABLE $_tableTwoName ($_columnIdForUser INTEGER PRIMARY KEY,
    $_columnFirstName  text not null,
    $_columnLastName  text not null,
    $_columnStartDate  text not null,
    $_columnLastDate  text not null,
    $_columnDarkMode int not null)
    """);
  }

  Future addClass(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  Future addUserData(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableTwoName, row);
  }

  Future<List<Map<String, dynamic>>> getAllClasses() async {
    Database db = await instance.database;
    return await db
        .rawQuery('SELECT * FROM $_tableName ORDER BY $_columnId ASC');
  }

  // Future<List<Map<String, dynamic>>> getUserData() async {
  //   Database db = await instance.database;
  //   return await db.
  // }

  Future makeTable(String classTableName) async {
    Database db = await instance.database;
    db.execute("""
    CREATE TABLE IF NOT EXISTS $classTableName ($_columnIdForAttendance INTEGER PRIMARY KEY,
    $_columnDate TEXT NOT NULL,
    $_columnAttendance TEXT NOT NULL,
    $_columnAttendancePercentage TEXT NOT NULL)
    """);
  }

  Future addAttendance(String classTableName, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(classTableName, row);
  }

  Future<List<Map<String, dynamic>>> getAttendance(String classname) async {
    Database db = await instance.database;
    return await db
        .rawQuery('SELECT * FROM $classname ORDER BY $_columnId ASC');
  }

  Future<List<Map<String, dynamic>>> getAttendanceByDate(
      String classname, String date) async {
    Database db = await instance.database;
    return await db.rawQuery(
        'SELECT * FROM $classname WHERE $_columnDate = "$date" ORDER BY $_columnId ASC');
  }

  // Future addAttendance(String attendance) async {
  //   Database db = await instance.database;
  //   return await db.rawQuery('ALTER TABLE $_tableName ADD COLUMN $date text');
  // }

  // Future<int> insert(Map<String, dynamic> row) async {
  //   Database db = await instance.database;
  //   return await db.insert(_tableName, row);
  // }

  // Future<int> userinsert(Map<String, dynamic> row) async {
  //   Database db = await instance.database;
  //   return await db.insert(_usertablename, row);
  // }

  // Future<List<Map<String, dynamic>>> userqueryAll() async {
  //   Database db = await instance.database;
  //   return await db.rawQuery(
  //       'SELECT * FROM $_usertablename ORDER BY $_usercolumnfirstName ASC');
  // }

  // Future<List<Map<String, dynamic>>> transactionsByName(
  //     String givenname) async {
  //   Database db = await instance.database;
  //   return await db.rawQuery(
  //       'SELECT * FROM $_tableName WHERE $_columnName = "$givenname" ORDER BY $_columnId DESC');
  // }

//   int attendance(int index) {
//   List l = ['papa','paap','apap','apap','apap','apap','apap','apap','apap','apap','apap','apap','apap','apap','appa'];
//   int c = 0;
//   for(int i = 0; i< l.length; i++){
//     if(l[i][index]=='a'){
//       c++;
//     }
//   }
//   return c;
// }
}
