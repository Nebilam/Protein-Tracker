import 'package:flutter/material.dart';
import 'package:myapp/core/navbar/nav_bar.dart';
import 'package:myapp/main.dart';
import 'package:myapp/presentation/pages/authentication/login_signup/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);
    final session = supabase.auth.currentSession;

    if (!mounted) return;
    if (session != null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
