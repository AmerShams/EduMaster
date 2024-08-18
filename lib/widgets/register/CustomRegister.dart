// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:courseproject/static/utils.dart';
import 'package:flutter/material.dart';

class CustomRegisterAuth extends StatelessWidget {
  final String hinttext;
  final IconData iconData;
  final TextEditingController? mycontroller;
  final String? Function(String?) valid;
  final bool isNumber;

  const CustomRegisterAuth({
    super.key,
    required this.hinttext,
    required this.iconData,
    required this.mycontroller,
    required this.valid,
    required this.isNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: screenWidth(33)),
      child: TextFormField(
        keyboardType: isNumber
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        validator: valid,
        controller: mycontroller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          hintText: hinttext,
          hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(
              vertical: screenHeight(70), horizontal: screenWidth(17)),
          suffixIcon: Icon(
            iconData,
            size: 18,
          ),
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
      ),
    );
  }
}
