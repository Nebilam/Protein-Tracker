import 'dart:async';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/common/functions/execute_with_error_handling.dart';
import 'package:myapp/common/widgets/buttons/text_button.dart';
import 'package:myapp/main.dart';
import 'package:myapp/presentation/pages/authentication/account/acount_page.dart';
import 'package:myapp/presentation/pages/authentication/login_signup/login_page.dart';
import 'package:myapp/presentation/pages/authentication/login_signup/token_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:myapp/common/widgets/input_fields/input_field.dart';
import 'package:myapp/common/widgets/input_fields/password_field.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  final userNameField = InputField(hint: 'Username');
  final emailField = InputField(hint: 'Email');
  final passwordField = PasswordInputField(hint: 'Password');
  late final StreamSubscription<AuthState> _authSubscription;

  @override
  void initState() {
    super.initState();
    _authSubscription = supabase.auth.onAuthStateChange.listen((event) {
      final session = event.session;
      if (session != null) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AccountPage(),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: emailField,
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: passwordField,
              ),
              const SizedBox(height: 12),
              ButtonText(
                text: 'Sign Up',
                onPressed: () {
                  executeWithErrorHandling(
                      type: FunctionType.async,
                      context: context,
                      action: () async {
                        final email = emailField.controller.text.trim();
                        final password = passwordField.passwordController.text;
                        await supabase.auth.signUp(
                          email: email,
                          password: password,
                        );
                        if (mounted) {
                          AnimatedSnackBar.material(
                            "Check your inbox",
                            type: AnimatedSnackBarType.info,
                            snackBarStrategy: RemoveSnackBarStrategy(),
                            duration: const Duration(seconds: 3),
                            // ignore: use_build_context_synchronously
                          ).show(context);
                          Navigator.push(
                              // ignore: use_build_context_synchronously
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TokenPage(email: email)));
                        }
                      });
                },
              ),
              ButtonText(
                text: 'Sign In',
                style: Style.secondary,
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
              ),
            ],
          ),
        ));
  }
}
