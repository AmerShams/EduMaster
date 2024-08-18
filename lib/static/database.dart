import 'package:courseproject/static/static.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  final _myBox = Hive.box('mybox1');

  void createInitialData() {
    isAdmin = false;
    favoritecourses = [];
    notifications = [];
  }

  void loadData() {
    favoritecourses = _myBox.get("courses", defaultValue: []);
    isAdmin = _myBox.get("ISADMIN", defaultValue: false);
    notifications = _myBox.get("NOT", defaultValue: []);
  }

  // update the database
  void updateDataBase() {
    _myBox.put("courses", favoritecourses);
    _myBox.put("ISADMIN", isAdmin);
    _myBox.put("NOT", notifications);
  }

  void addNotification(List notification) {
    loadData();

    notifications.add(notification);
    updateDataBase();
  }
}
