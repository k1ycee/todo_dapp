import 'package:dapp/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String? buttonText;
  final VoidCallback? onPressed;
  final ButtonStyle? buttonStyle;
  final Color textColor;
  final double textFontSize;

  const CustomButton(
      {Key? key,
      this.buttonText,
      this.onPressed,
      this.buttonStyle,
      this.textColor = Colors.white,
      this.textFontSize = 16})
      : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Center(
        child: CustomText(
          widget.buttonText,
          fontSize: widget.textFontSize,
          color: widget.textColor,
        ),
      ),
      style: widget.buttonStyle,
      onPressed: widget.onPressed,
    );
  }
}