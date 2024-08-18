import 'package:courseproject/static/utils.dart';
import 'package:flutter/material.dart';

class CustomBodyAuth extends StatelessWidget {
  final String text;
  const CustomBodyAuth({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth(20)),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
