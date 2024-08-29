import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/common/widgets/future/future_widget.dart';
import 'package:myapp/core/riverpod/riverpod.dart';
import 'package:myapp/main.dart';
import 'package:myapp/common/widgets/selection/single_choice_selection.dart';

class FavouritesList extends ConsumerWidget {
  final Meals meal;

  const FavouritesList({
    super.key,
    required this.meal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String intakeListString = meal == Meals.breakfast
        ? 'breakfast'
        : meal == Meals.lunch
            ? 'lunch'
            : meal == Meals.dinner
                ? 'dinner'
                : 'snacks';
    final mealList = meal == Meals.breakfast
        ? ref.watch(mealDataOptions).breakfastData
        : meal == Meals.lunch
            ? ref.watch(mealDataOptions).lunchData
            : meal == Meals.dinner
                ? ref.watch(mealDataOptions).dinnerData
                : ref.watch(mealDataOptions).snacksData;
    return CustomFutureBuilder(
        future: mealList,
        builder: (context, data) {
          final meal = data;
          return ListView.builder(
            itemCount: meal.length,
            itemBuilder: (context, index) {
              final item = meal[index];
              List<Widget> subtitles = [];

              item.forEach((key, value) {
                if (key.startsWith('proteinDensity')) {
                  final proteinDensityKey = 'proteinDensity${key.substring(8)}';
                  final weightKey = 'weight${key.substring(8)}';
                  if (item.containsKey(weightKey)) {
                    subtitles.add(
                      Text(
                        '${item[proteinDensityKey]}g  •  $value x ${item[weightKey]}g',
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
                            onPressed: () async {
                              await supabase
                                  .from(intakeListString)
                                  .delete()
                                  .eq('id', item['id']);
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pop();
                              // ignore: unused_result
                              ref.refresh(mealData);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          );
        });
  }
}
