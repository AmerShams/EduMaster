import 'package:courseproject/static/utils.dart';
import 'package:flutter/material.dart';

class CustomTextFormAuth extends StatelessWidget {
  final String hinttext;
  final IconData iconData;
  final TextEditingController? mycontroller;
  final String? Function(String?) valid;
  final bool isNumber;
  final bool? obscureText;
  final void Function()? onTapIcon;

  const CustomTextFormAuth(
      {super.key,
      this.obscureText,
      this.onTapIcon,
      required this.hinttext,
      required this.iconData,
      required this.mycontroller,
      required this.valid,
      required this.isNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: screenWidth(30)),
      child: TextFormField(
        keyboardType: isNumber
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        validator: valid,
        controller: mycontroller,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          hintText: hinttext,
          hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(
              vertical: screenHeight(50), horizontal: screenWidth(17)),
          prefixIcon: obscureText == true
              ? IconButton(
                  onPressed: onTapIcon,
                  icon: const Icon(Icons.visibility),
                )
              : null,
          suffixIcon: Icon(iconData),
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
