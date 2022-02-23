import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  CustomTextfield(
      {required this.label,
      required this.keyboard,
      required this.fieldIcon,
      required this.onChange,
      this.obscureText = false,
      this.textEditingController});

  TextInputType keyboard;
  IconData fieldIcon;
  VoidCallback onChange;
  bool obscureText = false;
  TextEditingController? textEditingController;
  String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: textEditingController,
        obscureText: obscureText,
        onChanged: (value) => onChange,
        keyboardType: keyboard,
        decoration: InputDecoration(
          label: Text(label),
          prefixIcon: Icon(fieldIcon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }
}
