import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  String text;
  Color color;
  TextAlign align;
  double fontSize;

  CustomTitle(
      {this.text = "",
      this.color = Colors.black,
      this.align = TextAlign.start,
      this.fontSize = 30});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
      ),
    );
  }
}
