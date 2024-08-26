import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/main.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../common/widgets/input_fields/input_field.dart';
import '../../../../common/widgets/input_fields/password_field.dart';
import '../../../../core/navbar/nav_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            builder: (context) => const HomePage(),
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
          title: const Text('Login'),
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            emailField,
            const SizedBox(height: 12),
            passwordField,
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                try {
                  final email = emailField.controller.text.trim();
                  final password = passwordField.passwordController.text;
                  await supabase.auth.signUp(
                      email: email,
                      password: password,
                      emailRedirectTo:
                          'io.supabase.flutterquickstart://login-callback/');
                  if (mounted) {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Check your inbox'),
                      ),
                    );
                  }
                } on AuthException catch (error) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(error.message),
                      // ignore: use_build_context_synchronously
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  );
                } catch (error) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Error occured, please retry.'),
                      // ignore: use_build_context_synchronously
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  );
                }
              },
              child: const Text('Login'),
            ),
          ],
        ));
  }
}
