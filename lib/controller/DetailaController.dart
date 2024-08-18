// ignore_for_file: file_names

import 'package:courseproject/controller/favoriteController.dart';
import 'package:courseproject/static/database.dart';
import 'package:courseproject/static/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class DetailsController extends GetxController {
  ToDoDataBase db = ToDoDataBase();
  final _myBox = Hive.box('mybox1');

  @override
  void onInit() {
    super.onInit();
    if (_myBox.get("courses") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  void addToFavorites(Map<dynamic, dynamic> course) {
    final existingCourse = favoritecourses.firstWhere(
      (c) => c['title'] == course['title'],
      orElse: () => {},
    );

    if (existingCourse.isEmpty) {
      favoritecourses.add(course);
      db.updateDataBase();

      FavoriteController cont = Get.find();
      cont.update();
      Get.snackbar(
        'Success',
        'Course added to favorites!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Already Added',
        'This course is already in your favorites.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    }
  }
}
