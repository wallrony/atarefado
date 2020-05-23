import 'package:flutter/material.dart';

push(context, page, { bool replace }) {
  Navigator.of(context).push(makePageRoute(page));
}

makePageRoute(page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return makeTransition(animation, child);
    }
  );
}

makeTransition(animation, child) {
  var begin = Offset(1, 0);
  var end = Offset.zero;
  var curve = Curves.easeOut;
  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  return SlideTransition(
    position: animation.drive(tween),
    child: child,
  );
}