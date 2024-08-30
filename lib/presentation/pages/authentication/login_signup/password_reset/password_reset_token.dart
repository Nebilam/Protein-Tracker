import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/common/functions/execute_with_error_handling.dart';
import 'package:myapp/common/widgets/buttons/text_button.dart';
import 'package:myapp/main.dart';
import 'package:myapp/presentation/pages/authentication/login_signup/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:myapp/common/widgets/input_fields/input_field.dart';

class PasswordResetToken extends ConsumerWidget {
  final tokenField = InputField(hint: 'Token');
  final String newPassword;
  final String email;

  PasswordResetToken(
      {super.key, required this.newPassword, required this.email});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset password'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: tokenField,
          ),
          const SizedBox(height: 12),
          ButtonText(
            text: "Reset password",
            onPressed: () => executeWithErrorHandling(
                type: FunctionType.async,
                context: context,
                action: () async {
                  await supabase.auth.verifyOTP(
                    email: email,
                    token: tokenField.controller.text,
                    type: OtpType.recovery,
                  );
                  await supabase.auth.updateUser(UserAttributes(
                    password: newPassword,
                  ));
                  Navigator.pushReplacement(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                }),
          ),
        ],
      ),
    );
  }
}
