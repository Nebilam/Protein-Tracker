// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../presentation/pages/home/home.dart';
import '../../presentation/pages/tracker/tracker.dart';
import '../../presentation/pages/statistics/statistics.dart';
import '../../presentation/pages/settings/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(Icons.track_changes),
              label: "Tracker",
            ),
            NavigationDestination(
              icon: Icon(Icons.pie_chart_rounded),
              label: "Statistics",
              enabled: false,
            ),
            NavigationDestination(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
        ),
        body: [
          Home(),
          Tracker(),
          Statistics(),
          Settings(),
        ][currentPageIndex],
      ),
    );
  }
}
