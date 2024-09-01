import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/common/widgets/future/future_widget.dart';
import 'package:myapp/core/riverpod/riverpod.dart';
import 'package:myapp/common/widgets/selection/single_choice_selection.dart';

class IntakeList extends ConsumerWidget {
  final Meals intake;

  const IntakeList({
    super.key,
    required this.intake,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String intakeListString = intake == Meals.breakfast
        ? 'breakfast'
        : intake == Meals.lunch
            ? 'lunch'
            : intake == Meals.dinner
                ? 'dinner'
                : 'snacks';
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
                      RichText(
                        text: TextSpan(
                            text: '${item[proteinsKey]}g  •  ',
                            style: const TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                  text: '$value x ${item[weightKey]}g',
                                  style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.normal,
                                  )),
                            ]),
                      ),
                    );
                  }
                }
              });

              return SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  children: [
                    Card(
                      child: ListTile(
                        title: Text(item['name']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: subtitles,
                        ),
                        onLongPress: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirm Delete'),
                                content: const Text(
                                    'Are you sure you want to delete this item?'),
                                actions: [
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Delete'),
                                    onPressed: () {
                                      ref
                                          .read(mealData)
                                          .delete(intakeListString, item['id']);
                                      // ignore: use_build_context_synchronously
                                      Navigator.of(context).pop();
                                      ref.invalidate(mealData);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        tileColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
