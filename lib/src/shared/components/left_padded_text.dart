import 'package:flutter/material.dart';

class LeftPaddedText extends StatelessWidget {
  const LeftPaddedText({
    Key? key,
    required this.text,
    required this.style,
  }) : super(key: key);

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Text(text, style: style),
    );
  }
}
