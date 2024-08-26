import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/main.dart';
import 'package:myapp/presentation/pages/authentication/account/account_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/navbar/nav_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  late final StreamSubscription<AuthState> _authSubscription;

  @override
  void initState() {
    super.initState();
    _authSubscription = supabase.auth.onAuthStateChange.listen((event) {
      final session = event.session;
      if (session != null) {
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
    _emailController.dispose();
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
            TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  hintText: "Email",
                )),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                try {
                  final email = _emailController.text.trim();
                  await supabase.auth.signInWithOtp(
                    email: email,
                    emailRedirectTo:
                        'io.supabase.flutterquickstart://login-callback/',
                  );
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Check your inbox'),
                      ),
                    );
                  }
                } on AuthException catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(error.message),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  );
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Error occured, please retry.'),
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
