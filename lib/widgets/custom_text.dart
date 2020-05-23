import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomText extends StatelessWidget {
  String text;
  Color color;
  double fontSize;
  TextAlign align;
  bool isBold;

  CustomText(
      {this.text = "",
      this.color = Colors.black,
      this.fontSize = 16,
      this.align = TextAlign.start,
      this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 300),
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        fontFamily: Theme.of(context).textTheme.headline1.fontFamily
      ),
      child: Text(
        text,
        textAlign: align,
      ),
    );
  }
}
