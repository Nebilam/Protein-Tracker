import 'package:flutter/material.dart';
import 'package:passwordfield/passwordfield.dart';

class PasswordInputField extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();
  final String hint;

  PasswordInputField({super.key, required this.hint});

  @override
  Widget build(BuildContext context) {
    return PasswordField(
      color: Colors.blue,
      controller: passwordController,
      passwordConstraint: r'.{6,}',
      passwordDecoration: PasswordDecoration(),
      hintText: hint,
      border: PasswordBorder(
        border: OutlineInputBorder(
          borderSide: const BorderSide(),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 2, color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(width: 2, color: Colors.red.shade200),
        ),
      ),
      errorMessage: 'must contain 6 characters or more',
      hasFloatingPlaceholder: true,
    );
  }
}
