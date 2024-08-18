// ignore_for_file: file_names

import 'package:courseproject/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeController extends GetxController {
  final Rxn<User> user = Rxn<User>();
  final courses = [].obs; // قائمة للدورات
  final searchQuery = ''.obs; // متغير البحث
  var isLoading = true.obs; // مؤشر التحميل
  DatabaseReference coursesRef =
      FirebaseDatabase.instance.ref().child('courses');

  @override
  void onInit() {
    user.value = FirebaseAuth.instance.currentUser;
    fetchCourses(); // استرداد الدورات عند التهيئة
    super.onInit();
  }

  void fetchCourses() {
    isLoading.value = true; // بدء التحميل
    coursesRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        courses.value = data.values.toList();
      }
      isLoading.value = false; // إنهاء التحميل
    });
  }

  Future<void> signOut() async {
    if (await GoogleSignIn().isSignedIn()) {
      await GoogleSignIn().disconnect();
    }
    await FirebaseAuth.instance.signOut();
    Get.offAll(const LoginPage());
  }
}
