import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  String label;
  TextEditingController controller;
  Function validateFunction;
  int maxLines;

  CustomFormField(
      this.controller, {this.label = "", this.validateFunction, this.maxLines = 1,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8, bottom: 4),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(.03),
          borderRadius: BorderRadius.circular(4),
      ),
      child: TextFormField(
        maxLines: maxLines,
        validator: (String text) => validateFunction(text),
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle:
          TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
          border: InputBorder.none,
          errorStyle: TextStyle(height: 1.5),
        ),
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
