import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double fontSize;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final Color color;
  const CustomText(this.text,
      {Key? key,
      this.fontSize = 27,
      this.fontWeight = FontWeight.normal,
      this.fontStyle = FontStyle.normal,
      this.textAlign = TextAlign.start,
      this.overflow = TextOverflow.fade,
      this.color = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: textAlign,
      overflow: overflow,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        color: color,
      ),
    );
  }
}