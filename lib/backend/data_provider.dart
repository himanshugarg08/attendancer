//import 'package:attendancer_final_code/backend/models.dart';

import 'package:attendancer_final_code/backend/database_helper.dart';
import 'package:attendancer_final_code/configs/utils.dart';
import 'package:flutter/foundation.dart';

class BackEnd extends ChangeNotifier {
  List<Map<String, dynamic>> _classList = [];

  List<Map<String, dynamic>> get classList => _classList;

  Future<void> getclass() async {
    _classList = await DatabaseHelper.instance.getAllClasses();

    notifyListeners();
  }

  Future<void> addclass(String className, int start, int end, String prefix,
      String suffix) async {
    Map<String, dynamic> classToAdd = {
      "classname": className,
      "start": start,
      "end": end,
      "prefix": prefix,
      "suffix": suffix,
      "isdone": 0
    };

    int i = await DatabaseHelper.instance.addClass(classToAdd);
    await DatabaseHelper.instance.makeTable(className);
    if (i != null) {
      print("Class Added at " + i.toString());
    } else {
      print("Error");
    }
  }
}
