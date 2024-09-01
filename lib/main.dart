// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/core/theme/theme.dart';
import 'package:myapp/presentation/pages/authentication/splash/splash_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://wnyxlcdvwddxrfcrgrzp.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndueXhsY2R2d2RkeHJmY3JncnpwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjQ2NzQ3NTQsImV4cCI6MjA0MDI1MDc1NH0.OsMhg7qMZ1B1jCK4RtlUAVIAWAD3EyNcosdyw9UrHTc',
  );
  runApp(const ProviderScope(child: MyApp()));
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemedMaterialApp(
      home: const SplashPage(),
    );
  }
}
