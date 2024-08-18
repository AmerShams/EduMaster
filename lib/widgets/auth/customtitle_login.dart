import 'package:flutter/material.dart';

class CustomtextTitleLog extends StatelessWidget {
  final String text;
  const CustomtextTitleLog({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.displayLarge,
    );
  }
}
