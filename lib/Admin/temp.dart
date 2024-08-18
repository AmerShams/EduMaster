import 'package:courseproject/Admin/AddCources.dart';
import 'package:courseproject/Admin/Login_Page.dart';
import 'package:courseproject/controller/TempController.dart';
import 'package:courseproject/static/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class TempView extends StatelessWidget {
  const TempView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TempController());
    return GetBuilder<TempController>(
      builder: (controller) {
        return isAdmin == true ? const AddCourses() : const Login();
      },
    );
  }
}
