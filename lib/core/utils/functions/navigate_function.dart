import 'dart:async';

import 'package:flutter/material.dart';

void navigateTo(
  BuildContext context,
  Widget widget, {
  FutureOr<dynamic> Function(dynamic)? onValue,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  ).then(onValue ?? (_) {});
}

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false);

void navigateWithSlideUp(
  BuildContext context,
  Widget widget, {
  FutureOr<dynamic> Function(dynamic)? onValue,
}) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0); // Start from bottom
        const end = Offset.zero; // End at normal position
        const curve = Curves.easeInOut; // Smooth animation

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ),
  ).then(onValue ?? (_) {});
}
