import 'package:afazeres/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomButtonIcon extends StatelessWidget {
  Function onPressed;
  Icon icon;
  String label;
  bool isBold;
  Color backgroundColor;
  bool withElevation;
  Color itensColor;
  bool fullWidth;

  CustomButtonIcon({
    this.onPressed,
    this.icon,
    this.label,
    this.isBold = false,
    this.backgroundColor = Colors.cyan,
    this.withElevation = true,
    this.itensColor = Colors.white,
    this.fullWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      icon = Icon(icon.icon, color: itensColor);
    }

    final button = FlatButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: CustomText(
        text: this.label,
        color: itensColor,
        isBold: isBold,
      ),
    );

    return fullWidth
        ? Container(
            padding: EdgeInsets.all(4),
            width: double.maxFinite,
            color: backgroundColor,
            child: button,
          )
        : button;
  }
}
