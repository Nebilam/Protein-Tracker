import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/common/widgets/buttons/text_button.dart';
import 'package:myapp/main.dart';
import 'package:myapp/presentation/pages/authentication/login_signup/login_page.dart';
import 'package:myapp/presentation/pages/authentication/login_signup/token_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../common/widgets/input_fields/input_field.dart';
import '../../../../common/widgets/input_fields/password_field.dart';
import '../../../../core/navbar/nav_bar.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
          title: const Text('Sign Up'),
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
                text: 'Sign Up',
                onPressed: () async {
                  try {
                    final email = emailField.controller.text.trim();
                    final password = passwordField.passwordController.text;
                    await supabase.auth.signUp(
                      email: email,
                      password: password,
                    );
                    if (mounted) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Check your inbox'),
                        ),
                      );
                      Navigator.push(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                              builder: (context) => TokenPage(email: email)));
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
