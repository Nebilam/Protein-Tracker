import 'package:flutter/material.dart';
import 'package:myapp/core/extensions/string_extension.dart';
import 'package:myapp/presentation/pages/home/favourites_list.dart';
import 'package:myapp/presentation/pages/home/intake_list.dart';

enum SelectionChoice { intakeList, favourites }

enum Meals { breakfast, lunch, dinner, snacks }

class SingleChoice extends StatefulWidget {
  final SelectionChoice container;
  const SingleChoice({super.key, required this.container});
  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  Meals meal = Meals.breakfast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SegmentedButton<Meals>(
            segments: const <ButtonSegment<Meals>>[
              ButtonSegment<Meals>(
                value: Meals.breakfast,
                icon: Icon(Icons.free_breakfast),
              ),
              ButtonSegment<Meals>(
                value: Meals.lunch,
                icon: Icon(Icons.lunch_dining),
              ),
              ButtonSegment<Meals>(
                value: Meals.dinner,
                icon: Icon(Icons.restaurant),
              ),
              ButtonSegment<Meals>(
                value: Meals.snacks,
                icon: Icon(Icons.fastfood),
              ),
            ],
            selected: <Meals>{
              meal
            },
            onSelectionChanged: (Set<Meals> newSelection) {
              setState(() {
                // By default there is only a single segment that can be
                // selected at one time, so its value is always the first
                // item in the selected set.
                meal = newSelection.first;
              });
            }),
        const SizedBox(height: 20),
        Text(
          meal.name.capitalize(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: widget.container == SelectionChoice.intakeList
              ? IntakeList(
                  intake: meal,
                )
              : const FavouritesList(),
        ),
      ],
    );
  }
}
