import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/common/widgets/future/future_widget.dart';
import 'package:myapp/core/riverpod/riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'single_choice_selection.dart';
import '../../popups/profile/profile.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ignore: unused_result
    ref.refresh(mealData);
    // ignore: unused_result
    ref.refresh(userData);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              child: const CircleAvatar(
                radius: 20,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
              },
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Welcome Back", style: TextStyle(fontSize: 12)),
                CustomFutureBuilder(
                  future: ref.watch(userData).userName,
                  builder: (context, data) {
                    final name = data;
                    return Text(name[0]['username'].toString());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Center(
              child: CustomFutureBuilder(
                  future: ref.watch(mealData).sumProteins(),
                  builder: (context, data) {
                    final currentIntake = data;
                    return CustomFutureBuilder(
                        future: ref.watch(userData).goalIntake,
                        builder: (context, data) {
                          final goalIntake = data[0]['goal_intake'];
                          return CircularPercentIndicator(
                              radius: 150.0,
                              lineWidth: 10.0,
                              animation: true,
                              percent: currentIntake / goalIntake > 1
                                  ? 1
                                  : currentIntake / goalIntake,
                              center: Column(
                                children: [
                                  const SizedBox(height: 110),
                                  Text(
                                      "${int.parse(((currentIntake / goalIntake) * 100).toStringAsFixed(0))}%",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40,
                                      )),
                                  GestureDetector(
                                    child: Text(
                                        "$currentIntake of $goalIntake grams",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        )),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Profile()));
                                    },
                                  ),
                                ],
                              ),
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor:
                                  Theme.of(context).colorScheme.inversePrimary);
                        });
                  })),
          const SizedBox(
            height: 30,
          ),
          const Expanded(child: SingleChoice())
        ]),
      ),
    );
  }
}
