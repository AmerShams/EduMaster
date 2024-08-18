// ignore_for_file: file_names

import 'package:courseproject/static/database.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: camel_case_types
class TempController extends GetxController {
  ToDoDataBase db = ToDoDataBase();
  final _myBox = Hive.box('mybox1');

  @override
  void onInit() {
    super.onInit();
    if (_myBox.get("ISADMIN1") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }
}
