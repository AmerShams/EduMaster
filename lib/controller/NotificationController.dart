// ignore_for_file: file_names

import 'package:courseproject/controller/HomeController.dart';
import 'package:courseproject/static/database.dart';
import 'package:courseproject/static/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class NotificationsController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final myBox = Hive.box('mybox1');
  ToDoDataBase db = ToDoDataBase();
  @override
  void onInit() {
    if (myBox.get("NOT") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.onInit();
  }

  String getCurrentTime() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('hh-mm a').format(now);
    return formattedTime;
  }

  deletenotification(int index) {
    notifications.removeAt(index);
    db.updateDataBase();
    update();
    HomeController cont = Get.put(HomeController());
    cont.refresh();
  }
}
