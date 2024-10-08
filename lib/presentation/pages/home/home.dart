import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/core/riverpod/riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'single_choice_selection.dart';
import '../../popups/profile/profile.dart';

class Home extends ConsumerWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Welcome Back", style: TextStyle(fontSize: 12)),
                Text(ref.watch(userData).name.toString()),
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
                percent: ref.watch(proteins).percentageIntake.toDouble(),
                center: Column(
                  children: [
                    const SizedBox(height: 110),
                    Text(
                        "${ref.watch(proteins).roundPercentageIntake.toInt()}%",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        )),
                    GestureDetector(
                      child: Text(
                          "${ref.watch(proteins).currentIntake.toInt()} of ${ref.watch(proteins).goalIntake.toInt()} grams",
                          style: const TextStyle(
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
