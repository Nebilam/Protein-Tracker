import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/common/widgets/future/future_widget.dart';
import 'package:myapp/core/riverpod/riverpod.dart';
import 'package:myapp/presentation/pages/home/single_choice_selection.dart';

class IntakeList extends ConsumerWidget {
  final Meals intake;

  const IntakeList({super.key, required this.intake});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intakeList = intake == Meals.breakfast
        ? ref.watch(mealData).breakfastData
        : intake == Meals.lunch
            ? ref.watch(mealData).lunchData
            : intake == Meals.dinner
                ? ref.watch(mealData).dinnerData
                : ref.watch(mealData).snacksData;
    return CustomFutureBuilder(
        future: intakeList,
        builder: (context, data) {
          final meal = data;
          return ListView.builder(
            itemCount: meal.length,
            itemBuilder: (context, index) {
              final item = meal[index];
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
        });
  }
}
