// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:courseproject/controller/CustomLoginController.dart';
import 'package:courseproject/static/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomLoginAuth1 extends StatelessWidget {
  final String hinttext;
  final TextEditingController? mycontroller;
  final String? Function(String?) valid;
  final bool? obscureText;

  const CustomLoginAuth1({
    super.key,
    this.obscureText,
    required this.hinttext,
    required this.mycontroller,
    required this.valid,
  });

  @override
  Widget build(BuildContext context) {
    final CustomLoginAuthController controller =
        Get.put(CustomLoginAuthController());

    return Container(
      margin: EdgeInsets.only(bottom: screenWidth(33)),
      child: GetBuilder<CustomLoginAuthController>(
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
                  vertical: screenHeight(50), horizontal: screenWidth(17)),
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
