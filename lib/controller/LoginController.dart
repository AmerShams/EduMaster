// ignore_for_file: use_build_context_synchronously, file_names, empty_catches

import 'package:courseproject/Bottombar/bottombar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:courseproject/controller/HomeController.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  var isLoading = false.obs;
  bool isloading2 = false;
  final GlobalKey<FormState> loginFormKey =
      GlobalKey<FormState>(); // استخدام مفتاح منفصل

  Future login(BuildContext context) async {
    if (loginFormKey.currentState!.validate()) {
      try {
        isloading2 = true;
        update();
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: email.text.trim(), password: password.text.trim());

        if (credential.user!.emailVerified) {
          isloading2 = false;
          update();
          final HomeController homeController = Get.find();
          homeController.update();
          Get.offAll(const MyHomePage());
        } else {
          isloading2 = false;
          update();
          try {
            FirebaseAuth.instance.currentUser!.sendEmailVerification();
            Get.snackbar("please verifiy Your Email in spam", '');
          } catch (e) {}
        }
      } on FirebaseAuthException catch (e) {
        isloading2 = false;
        update();
        if (e.code == 'user-not-found') {
          showErrorDialog(context, 'No user found for that email.');
        } else if (e.code == 'wrong-password') {
          showErrorDialog(context, 'Wrong password provided.');
        } else {
          showErrorDialog(context, e.toString());
        }
      } catch (e) {}
    }
  }

  void reset(BuildContext context) async {
    String emailText = email.text.trim();
    RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');

    if (emailText.isEmpty || !emailRegex.hasMatch(emailText)) {
      showErrorDialog(
          context, 'يرجى إدخال بريد إلكتروني صالح لإعادة تعيين كلمة المرور.');
      return;
    }

    try {
      Get.defaultDialog(
        title: 'هل تريد إعادة تعيين كلمة المرور عبر البريد الإلكتروني؟',
        middleText: '',
        backgroundColor: const Color.fromARGB(255, 201, 227, 235),
        titleStyle: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        radius: 10.0,
        actions: [
          ElevatedButton.icon(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.cancel),
            label: const Text('إلغاء'),
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 255, 255, 255),
              backgroundColor: Colors.red,
            ),
          ),
          ElevatedButton.icon(
            onPressed: () async {
              await FirebaseAuth.instance
                  .sendPasswordResetEmail(email: emailText);
              Get.back();
            },
            icon: const Icon(Icons.check),
            label: const Text('موافق'),
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 255, 255, 255),
              backgroundColor: Colors.green,
            ),
          ),
        ],
      );
    } catch (e) {
      showErrorDialog(context, e.toString());
    }
  }

  Future signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      isLoading.value = true;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      isLoading.value = false;

      final HomeController homeController = Get.find();
      homeController.user.value = userCredential.user;
      homeController.update();

      Get.offAll(const MyHomePage());
    } catch (e) {
      isLoading.value = false;
      showErrorDialog(context, e.toString());
    }
  }

  void showErrorDialog(BuildContext context, String message) {
    Get.defaultDialog(
      title: "Error",
      middleText: message,
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
          icon: const Icon(Icons.check),
          label: const Text('Ok'),
          style: ElevatedButton.styleFrom(
            foregroundColor: const Color.fromARGB(191, 17, 66, 130),
            backgroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
