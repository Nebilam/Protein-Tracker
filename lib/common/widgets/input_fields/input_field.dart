import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  dynamic controller;
  final String hint;
  final String? label;

  InputField(
      {super.key, required this.hint, this.label, this.controller = 'empty'});

  @override
  Widget build(BuildContext context) {
    controller = controller == 'empty' ? TextEditingController() : controller;
    return TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          hintText: hint,
          labelText: label ?? hint,
        ));
  }
}
