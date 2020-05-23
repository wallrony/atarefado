import 'package:afazeres/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  Function onPressed;
  String label;
  bool bottomBtn;

  CustomButton({
    this.onPressed,
    this.label,
    this.bottomBtn = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: ButtonTheme(
        height: 0,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: FlatButton(
          padding: EdgeInsets.all(16),
          shape: !bottomBtn
              ? null
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(48),
                    bottomRight: Radius.circular(48),
                  ),
                ),
          onPressed: onPressed,
          child: CustomText(
            text: this.label,
            color: Colors.white,
            fontSize: 18,
            isBold: true,
          ),
          color: Colors.cyan,
        ),
      ),
    );
  }
}
