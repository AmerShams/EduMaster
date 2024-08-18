// ignore_for_file: file_names

import 'package:get/get.dart';

class CustomRegisterAuthController extends GetxController {
  bool obscureText = true;

  void toggleObscureText() {
    obscureText = !obscureText;
    update();
  }
}
