import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/common/widgets/future/future_widget.dart';
import 'package:myapp/common/widgets/listview/favourites_listview_builder.dart';
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
    List<Widget> buttonList = <Widget>[
      IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined)),
      IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
      IconButton(onPressed: () {}, icon: const Icon(Icons.delete_outline)),
      IconButton(onPressed: () {}, icon: const Icon(Icons.archive_outlined)),
      IconButton(onPressed: () {}, icon: const Icon(Icons.settings_outlined)),
      IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
    ];
    List<Text> labelList = const <Text>[
      Text('Share'),
      Text('Add to'),
      Text('Trash'),
      Text('Archive'),
      Text('Settings'),
      Text('Favorite')
    ];

    buttonList = List.generate(
        buttonList.length,
        (index) => Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buttonList[index],
                  labelList[index],
                ],
              ),
            ));

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
          return SingleChildScrollView(
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
                            buttonList: buttonList,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          child: FavouritesListviewBuilder(
                            list: list2,
                            mealType: mealType,
                            buttonList: buttonList,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ));
        });
  }
}
