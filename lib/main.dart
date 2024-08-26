// ignore_for_file: prefer_const_constructors
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:myapp/presentation/pages/authentication/splash/splash_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://wnyxlcdvwddxrfcrgrzp.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndueXhsY2R2d2RkeHJmY3JncnpwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjQ2NzQ3NTQsImV4cCI6MjA0MDI1MDc1NH0.OsMhg7qMZ1B1jCK4RtlUAVIAWAD3EyNcosdyw9UrHTc',
  );
  usePathUrlStrategy();
  runApp(const ProviderScope(child: MyApp()));
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final _defaultLightColorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.blue);

  static final _defaultDarkColorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.blue, brightness: Brightness.dark);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: lightColorScheme ?? _defaultLightColorScheme,
            fontFamily: 'Nunito',
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
            fontFamily: 'Nunito',
          ),
          themeMode: ThemeMode.dark,
          home: const SplashPage());
    });
  }
}
