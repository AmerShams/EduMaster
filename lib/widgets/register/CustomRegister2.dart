// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:courseproject/controller/register/CustomRegisterController2.dart';
import 'package:courseproject/static/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomRegisterAuth2 extends StatelessWidget {
  final String hinttext;
  final TextEditingController? mycontroller;
  final String? Function(String?) valid;
  final bool? obscureText;

  const CustomRegisterAuth2({
    super.key,
    this.obscureText,
    required this.hinttext,
    required this.mycontroller,
    required this.valid,
  });

  @override
  Widget build(BuildContext context) {
    final CustomRegisterAuthController2 controller =
        Get.put(CustomRegisterAuthController2());

    return Container(
      margin: EdgeInsets.only(bottom: screenWidth(33)),
      child: GetBuilder<CustomRegisterAuthController2>(
        init: controller,
        builder: (_) {
          return TextFormField(
            keyboardType: TextInputType.text,
            validator: valid,
            controller: mycontroller,
            obscureText: controller.obscureText,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              hintText: hinttext,
              hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: EdgeInsets.symmetric(
                  vertical: screenHeight(70), horizontal: screenWidth(17)),
              suffixIcon: obscureText == true
                  ? IconButton(
                      onPressed: controller.toggleObscureText,
                      icon: Icon(
                        controller.obscureText
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          );
        },
      ),
    );
  }
}
