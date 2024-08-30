import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/common/functions/execute_with_error_handling.dart';
import 'package:myapp/common/widgets/buttons/text_button.dart';
import 'package:myapp/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:myapp/common/widgets/input_fields/input_field.dart';

class TokenPage extends ConsumerWidget {
  final tokenField = InputField(hint: 'Token');
  final String email;

  TokenPage({super.key, required this.email});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Token Page'),
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
            text: "Verify sign up",
            onPressed: () => executeWithErrorHandling(
                type: FunctionType.async,
                context: context,
                action: () async {
                  await supabase.auth.verifyOTP(
                    email: email,
                    token: tokenField.controller.text,
                    type: OtpType.email,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
