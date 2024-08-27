// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myapp/main.dart';
import 'package:myapp/presentation/pages/authentication/login_signup/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<void> _signOut() async {
    try {
      await supabase.auth.signOut();
    } on AuthException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(error.message),
            backgroundColor: Theme.of(context).colorScheme.error));
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Unexpected error occurred"),
            backgroundColor: Theme.of(context).colorScheme.error));
      }
    } finally {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextButton(onPressed: _signOut, child: const Text('Sign Out')),
    );
  }
}
