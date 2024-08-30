import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/common/functions/execute_with_error_handling.dart';
import 'package:myapp/common/widgets/input_fields/password_field.dart';
import 'package:myapp/core/navbar/nav_bar.dart';
import 'package:myapp/main.dart';
import 'package:myapp/presentation/pages/authentication/login_signup/password_reset/password_reset.dart';
import 'package:myapp/presentation/pages/authentication/login_signup/signup_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:myapp/common/widgets/buttons/text_button.dart';
import 'package:myapp/common/widgets/input_fields/input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailField = InputField(hint: 'Email');
  // ignore: unused_field
  late final StreamSubscription<AuthState> _authSubscription;

  final passwordField = PasswordInputField(hint: 'Password');

  @override
  void initState() {
    super.initState();
    _authSubscription = supabase.auth.onAuthStateChange.listen((event) {
      final session = event.session;
      if (session != null) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
              text: "Sign In",
              onPressed: () {
                executeWithErrorHandling(
                    type: FunctionType.async,
                    context: context,
                    action: () async {
                      await supabase.auth.signInWithPassword(
                          email: emailField.controller.text.trim(),
                          password: passwordField.passwordController.text);
                    });
              },
            ),
            ButtonText(
              text: "Sign Up",
              style: Style.secondary,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignUp()));
              },
            ),
            const SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ResetPassword()));
              },
              child: RichText(
                  text: const TextSpan(text: "Forgot Password? ", children: [
                TextSpan(
                    text: "Reset Password",
                    style: TextStyle(
                      color: Colors.blue,
                    ))
              ])),
            )
          ],
        ),
      ),
    );
  }
}
