import 'package:flutter/material.dart';
import 'package:myapp/core/extensions/string_extension.dart';

import '../../../common/widgets/intake_list.dart';

List<Map<String, dynamic>> breakfast = [
  {
    "name": "Eggs",
    "proteinDensity": 0.254,
    "quantity": 1,
    "weight": 50,
    "proteins": double.parse((3 * (342 * 0.254)).toStringAsFixed(1)),
    "quantity2": 1,
    "weight2": 100,
    "proteins2": (1 * (100 * 0.2)).roundToDouble(),
    "quantity3": 2,
    "weight3": 100,
    "proteins3": (2 * (100 * 0.2)).roundToDouble(),
  },
  {
    "name": "Skyr",
    "proteinDensity": 0.254,
    "quantity": 1,
    "weight": 50,
    "proteins": double.parse((3 * (342 * 0.254)).toStringAsFixed(1)),
  },
  {
    "name": "Milk",
    "proteinDensity": 0.254,
    "quantity": 1,
    "weight": 50,
    "proteins": double.parse((3 * (342 * 0.254)).toStringAsFixed(1)),
  },
  {
    "name": "Cheese",
    "proteinDensity": 0.254,
    "quantity": 1,
    "weight": 50,
    "proteins": double.parse((3 * (342 * 0.254)).toStringAsFixed(1)),
  },
  {
    "name": "Nuts",
    "proteinDensity": 0.254,
    "quantity": 1,
    "weight": 50,
    "proteins": double.parse((3 * (342 * 0.254)).toStringAsFixed(1)),
  }
];
List<Map<String, dynamic>> lunch = [
  {
    "name": "Eggs",
    "proteinDensity": 0.254,
    "quantity": 2,
    "weight": 50,
    "proteins": double.parse((3 * (342 * 0.254)).toStringAsFixed(1)),
    "quantity2": 1,
    "weight2": 100,
    "proteins2": (1 * (100 * 0.2)).roundToDouble(),
    "quantity3": 2,
    "weight3": 100,
    "proteins3": (2 * (100 * 0.2)).roundToDouble(),
  },
];
List<Map<String, dynamic>> dinner = [
  {
    "name": "Eggs",
    "proteinDensity": 0.254,
    "quantity": 3,
    "weight": 50,
    "proteins": double.parse((3 * (342 * 0.254)).toStringAsFixed(1)),
    "quantity2": 1,
    "weight2": 100,
    "proteins2": (1 * (100 * 0.2)).roundToDouble(),
    "quantity3": 2,
    "weight3": 100,
    "proteins3": (2 * (100 * 0.2)).roundToDouble(),
  },
];
List<Map<String, dynamic>> snacks = [
  {
    "name": "Eggs",
    "proteinDensity": 0.254,
    "quantity": 4,
    "weight": 50,
    "proteins": double.parse((3 * (342 * 0.254)).toStringAsFixed(1)),
    "quantity2": 1,
    "weight2": 100,
    "proteins2": (1 * (100 * 0.2)).roundToDouble(),
    "quantity3": 2,
    "weight3": 100,
    "proteins3": (2 * (100 * 0.2)).roundToDouble(),
  },
];

enum Meals { breakfast, lunch, dinner, snacks }

class SingleChoice extends StatefulWidget {
  const SingleChoice({super.key});
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
          child: IntakeList(
            intake: meal,
          ),
        ),
      ],
    );
  }
}
