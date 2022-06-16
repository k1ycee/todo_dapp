import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String? title;
  final bool obscure;
  final TextEditingController? controller;
  final TextInputType? inputType;
  const CustomTextField(
      {Key? key,
      this.title,
      this.obscure = false,
      this.controller,
      this.inputType})
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: TextFormField(
        keyboardType: widget.inputType,
        controller: widget.controller,
        obscureText: !isPasswordVisible && widget.obscure,
        decoration: InputDecoration(
          hintText: widget.title,
          hintStyle: TextStyle(color: Colors.grey[400]),
          suffixIcon: widget.obscure
              ? IconButton(
                  icon: Icon(isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  color: Colors.grey[400])
              : null,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }
}