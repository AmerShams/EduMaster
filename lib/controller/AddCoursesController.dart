// ignore_for_file: depend_on_referenced_packages, file_names

import 'dart:io';
import 'package:courseproject/Bottombar/bottombar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class AddCoursesController extends GetxController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  bool isloading = false;
  TextEditingController title = TextEditingController();
  TextEditingController describition = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController rating = TextEditingController();
  TextEditingController coachname = TextEditingController();
  TextEditingController imageUrl = TextEditingController();
  TextEditingController courseUrl =
      TextEditingController(); // إضافة متحكم لخانة URL

  RxDouble uploadProgress = 0.0.obs; // لمتابعة تقدم التحميل

  DatabaseReference coursesRef =
      FirebaseDatabase.instance.ref().child('courses');

  @override
  void dispose() {
    title.dispose();
    describition.dispose();
    category.dispose();
    rating.dispose();
    coachname.dispose();
    imageUrl.dispose();
    courseUrl.dispose(); // تأكد من التخلص من المتحكم
    super.dispose();
  }

  void setLoading(bool value) {
    isloading = value;
    update();
  }

  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final imageName = basename(pickedFile.path);
      final ref = FirebaseStorage.instance.ref("images/$imageName");

      final uploadTask = ref.putFile(file);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        uploadProgress.value = snapshot.bytesTransferred / snapshot.totalBytes;
      });

      final snapshot = await uploadTask;
      final url = await snapshot.ref.getDownloadURL();
      imageUrl.text = url; // حفظ رابط الصورة في TextEditingController
      update();
    }
  }

  Future<void> addCourse() async {
    if (!formstate.currentState!.validate()) {
      return;
    }

    final newCourse = {
      'title': title.text,
      'description': describition.text,
      'category': category.text,
      'rating': rating.text,
      'coachName': coachname.text,
      'imagePath': imageUrl.text,
      'courseUrl': courseUrl.text,
    };

    setLoading(true);
    await coursesRef.push().set(newCourse);
    setLoading(false);

    // إعادة تعيين قيم الـ Controllers
    title.clear();
    describition.clear();
    category.clear();
    rating.clear();
    coachname.clear();
    imageUrl.clear();
    courseUrl.clear(); // إعادة تعيين خانة URL

    Get.off(const MyHomePage());
  }
}
