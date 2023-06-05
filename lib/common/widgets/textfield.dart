import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  CustomTextfield({super.key, required this.label, required this.controller});
  final TextEditingController controller;
  final String label;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == "") {
          return "Kya whai";
        } else {
          return null;
        }
      },
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.blue),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
