import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/core/riverpod/riverpod.dart';
import 'package:myapp/presentation/pages/home/single_choice_selection.dart';

class IntakeList extends ConsumerWidget {
  final Meals intake;

  const IntakeList({super.key, required this.intake});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<dynamic> intakeList = [];
    if (intake == Meals.breakfast) {
      intakeList = ref.watch(mealData).breakfastData;
    } else if (intake == Meals.lunch) {
      intakeList = ref.watch(mealData).lunchData;
    }
    // } else if (intake == Meals.dinner) {
    //   intakeList = ref.watch(dinnerData).dinnerData;
    // } else if (intake == Meals.snacks) {
    //   intakeList = ref.watch(snacksData).snacksData;
    // }
    return ListView.builder(
      itemCount: intakeList.length,
      itemBuilder: (context, index) {
        final item = intakeList[index];
        List<Widget> subtitles = [];

        item.forEach((key, value) {
          if (key.startsWith('quantity')) {
            final weightKey = 'weight${key.substring(8)}';
            final proteinsKey = 'proteins${key.substring(8)}';
            if (item.containsKey(weightKey)) {
              subtitles.add(
                Text(
                  '${item[proteinsKey]}g  •  $value x ${item[weightKey]}g',
                ),
              );
            }
          }
        });

        return ListTile(
          title: Text(item['name']),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: subtitles,
          ),
        );
      },
    );
  }
}
