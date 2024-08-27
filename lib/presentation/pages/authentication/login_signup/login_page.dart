import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/common/widgets/input_fields/password_field.dart';
import 'package:myapp/core/navbar/nav_bar.dart';
import 'package:myapp/main.dart';
import 'package:myapp/presentation/pages/authentication/login_signup/signup_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../common/widgets/input_fields/input_field.dart';

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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            emailField,
            const SizedBox(height: 12),
            passwordField,
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                try {
                  await supabase.auth.signInWithPassword(
                    email: emailField.controller.text.trim(),
                    password: passwordField.passwordController.text,
                  );
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
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 13),
                  child: Center(child: Text('Login')),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: GestureDetector(
                child: RichText(
                  text: const TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(fontFamily: 'Nunito'),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Sign up',
                        style: TextStyle(
                          color: Colors.blue,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUp()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
