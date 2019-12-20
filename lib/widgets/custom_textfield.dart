import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextInputType inputType;
  final TextEditingController controller;
  final TextInputAction inputAction;

  CustomTextField(
      {this.label, this.inputType, this.controller, this.inputAction});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.0,
          ),
        ),
        labelText: label,
      ),
      keyboardType: inputType,
      controller: controller,
      textInputAction: inputAction != null ? inputAction : TextInputAction.done,
    );
  }
}
