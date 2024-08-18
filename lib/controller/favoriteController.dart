// ignore_for_file: file_names

import 'package:courseproject/static/database.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class FavoriteController extends GetxController {
  ToDoDataBase db = ToDoDataBase();
  final _myBox = Hive.box('mybox1');

  @override
  void onInit() {
    // favoritecourses.clear();
    // db.updateDataBase();
    super.onInit();
    loadFavoriteCourses();
  }

  void loadFavoriteCourses() {
    if (_myBox.get("courses") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }
}
