import 'package:flutter/material.dart';

const Color mainGreen = Color(0xFF28AE61);
const Color slightWhite = Color(0xFFe6e6e6);
const double defaultFontSize = 24;
const BoxShadow defaultBoxShadow = BoxShadow(
  color: Colors.black45,
  blurRadius: 41,
  offset: Offset(0, -4),
  spreadRadius: 0.1,
  blurStyle: BlurStyle.normal,
);
BoxShadow defaultBoxShadowFun(double blurRadius) {
  return BoxShadow(
    color: Colors.black45,
    blurRadius: blurRadius,
    offset: const Offset(0, -4),
    spreadRadius: 0.1,
    blurStyle: BlurStyle.normal,
  );
}
