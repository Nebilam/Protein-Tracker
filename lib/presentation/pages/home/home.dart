import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'single_choice_selection.dart';
import '../../popups/profile/profile.dart';

class Home extends StatelessWidget {
  static const name = "Otis Lammertyn";

  static const int currentIntake = 110;
  static const int goalIntake = 150;
  static const double percentageIntake = currentIntake / goalIntake;
  final int roundPercentageIntake = (percentageIntake * 100).round();

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
              child: const CircleAvatar(
                radius: 20,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Profile()));
              },
            ),
            const SizedBox(width: 15),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome Back", style: TextStyle(fontSize: 12)),
                Text(name),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Center(
            child: CircularPercentIndicator(
                radius: 150.0,
                lineWidth: 10.0,
                animation: true,
                percent: percentageIntake,
                center: Column(
                  children: [
                    const SizedBox(height: 110),
                    Text("$roundPercentageIntake%",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        )),
                    GestureDetector(
                      child: const Text("$currentIntake of $goalIntake grams",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Profile()));
                      },
                    ),
                  ],
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Theme.of(context).colorScheme.inversePrimary),
          ),
          const SizedBox(
            height: 30,
          ),
          const Expanded(child: SingleChoice())
        ]),
      ),
    );
  }
}
