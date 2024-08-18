// ignore_for_file: unused_local_variable, file_names, non_constant_identifier_names

import 'package:courseproject/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repassword = TextEditingController();
  TextEditingController username = TextEditingController();
  bool isLoading = false;

  Future SignUp(BuildContext context) async {
    if (password.text.trim() != repassword.text.trim()) {
      Get.defaultDialog(
        title: "Error",
        middleText: "Passwords do not match",
        backgroundColor: const Color.fromARGB(255, 201, 227, 235),
        titleStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        middleTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
        radius: 10.0,
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.error, color: Colors.red),
            label: const Text('Ok'),
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color.fromARGB(191, 17, 66, 130),
              backgroundColor: Colors.white,
            ),
          ),
        ],
      );
      return;
    }

    try {
      isLoading = true;
      update();
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim());
      FirebaseAuth.instance.currentUser!.sendEmailVerification();
      isLoading = false;
      update();
      Get.defaultDialog(
        title: "Success",
        middleText: "Check your Email to verify your account",
        backgroundColor: const Color.fromARGB(255, 201, 227, 235),
        titleStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        middleTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
        radius: 10.0,
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Get.off(const LoginPage());
              Get.delete<SignController>();
            },
            icon: const Icon(Icons.check, color: Colors.green),
            label: const Text('Ok'),
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color.fromARGB(191, 17, 66, 130),
              backgroundColor: Colors.white,
            ),
          ),
        ],
      );
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      update();
      String errorMessage;
      Icon errorIcon;

      if (e.code == 'weak-password') {
        errorMessage = "The Password is too weak";
        errorIcon = const Icon(Icons.error, color: Colors.red);
      } else if (e.code == 'email-already-in-use') {
        errorMessage = "This Email is already Exists";
        errorIcon = const Icon(Icons.error, color: Colors.red);
      } else {
        errorMessage = e.toString();
        errorIcon = const Icon(Icons.error, color: Colors.red);
      }

      Get.defaultDialog(
        title: "Error",
        middleText: errorMessage,
        backgroundColor: const Color.fromARGB(255, 201, 227, 235),
        titleStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        middleTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
        radius: 10.0,
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Get.back();
            },
            icon: errorIcon,
            label: const Text('Ok'),
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color.fromARGB(191, 17, 66, 130),
              backgroundColor: Colors.white,
            ),
          ),
        ],
      );
    } catch (e) {
      isLoading = false;
      update();
      Get.defaultDialog(
        title: "Error",
        middleText: e.toString(),
        backgroundColor: const Color.fromARGB(255, 201, 227, 235),
        titleStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        middleTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
        radius: 10.0,
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.error, color: Colors.red),
            label: const Text('Ok'),
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color.fromARGB(191, 17, 66, 130),
              backgroundColor: Colors.white,
            ),
          ),
        ],
      );
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    repassword.dispose();
    username.dispose();
    super.dispose();
  }
}
