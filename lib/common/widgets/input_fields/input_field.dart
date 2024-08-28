import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final controller = TextEditingController();
  final String hint;
  final String initialValue;

  InputField({super.key, required this.hint, this.initialValue = ''});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        initialValue: initialValue,
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          hintText: hint,
          labelText: hint,
        ));
  }
}
