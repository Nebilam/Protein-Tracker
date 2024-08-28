import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final controller = TextEditingController();
  final String hint;
  final String? label;

  InputField({super.key, required this.hint, this.label});

  @override
  Widget build(BuildContext context) {
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
