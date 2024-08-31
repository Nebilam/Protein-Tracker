import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/common/widgets/future/future_widget.dart';
import 'package:myapp/presentation/pages/tracker/widgets/dialog.dart';
import 'package:myapp/presentation/pages/tracker/widgets/favourites_listview_builder.dart';
import 'package:myapp/core/riverpod/riverpod.dart';
import 'package:myapp/common/widgets/selection/single_choice_selection.dart';

class FavouritesList extends ConsumerWidget {
  final Meals meal;

  const FavouritesList({
    super.key,
    required this.meal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String mealType = meal == Meals.breakfast
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
          List list1 = [];
          List list2 = [];

          for (int i = 0; i < meal.length; i++) {
            if (i % 2 == 0) {
              list1.add(meal[i]);
            } else {
              list2.add(meal[i]);
            }
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Stack(
              children: [
                SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Card(
                                child: FavouritesListviewBuilder(
                                  list: list1,
                                  mealType: mealType,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Card(
                                child: FavouritesListviewBuilder(
                                  list: list2,
                                  mealType: mealType,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: FloatingActionButton(
                      tooltip: "Add new favourite",
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return FavouriteDialog(
                            title: "Add new favourite",
                            mealType: mealType,
                          );
                        }));
                      },
                      child: const Icon(Icons.add)),
                ),
              ],
            ),
          );
        });
  }
}
