import 'package:flutter/material.dart';
import 'package:myapp/common/functions/execute_with_error_handling.dart';
import 'package:myapp/common/widgets/buttons/text_button.dart';
import 'package:myapp/common/widgets/input_fields/input_field.dart';
import 'package:myapp/common/widgets/input_fields/password_field.dart';
import 'package:myapp/main.dart';
import 'package:myapp/presentation/pages/authentication/login_signup/password_reset/password_reset_token.dart';

class ResetPassword extends StatelessWidget {
  final InputField email = InputField(hint: "Email");
  final PasswordInputField newPasswordField = PasswordInputField(
    hint: "New Password",
  );
  ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: email,
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: newPasswordField,
            ),
            const SizedBox(height: 12),
            ButtonText(
                text: "Reset Password",
                onPressed: () => executeWithErrorHandling(
                    type: FunctionType.async,
                    context: context,
                    action: () async {
                      supabase.auth.resetPasswordForEmail(
                        email.controller.text.trim().toString(),
                      );
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PasswordResetToken(
                                    newPassword: newPasswordField
                                        .passwordController.text,
                                    email: email.controller.text.trim(),
                                  )));
                    })),
          ],
        ),
      ),
    );
  }
}
