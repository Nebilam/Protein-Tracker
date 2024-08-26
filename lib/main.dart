// ignore_for_file: prefer_const_constructors
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'core/navbar/nav_bar.dart';

void main() => runApp(const MyApp());

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
          home: const HomePage());
    });
  }
}
