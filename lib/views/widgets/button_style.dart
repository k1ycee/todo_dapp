import 'package:flutter/material.dart';

ButtonStyle buttonStyle(
    {Color color = Colors.white,
    double buttonWidth = 362,
    double buttonHeight = 54,
    double elevation = 1}) {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(color),
    elevation: MaterialStateProperty.all<double>(elevation),
    fixedSize: MaterialStateProperty.all<Size>(
      Size(
        buttonWidth,
        buttonHeight,
      ),
    ),
  );
}