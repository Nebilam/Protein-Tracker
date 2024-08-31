import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/core/riverpod/riverpod.dart';

late final id;
late final String name;
late final String mealType;
late final num weight; // TODO: Check if surely double
late final num proteinDensity; // TODO: Check if surely double

void customModelBottomSheet({
  required BuildContext context,
  required WidgetRef ref,
  required id,
  required String name,
  required String mealType,
  required num weight,
  required num proteinDensity,
}) {
  List<Widget> buttonList = <Widget>[
    IconButton(
        onPressed: () {
          ref.read(mealData).cloneAdd(mealType, name, proteinDensity, weight);
        },
        icon: const Icon(Icons.copy)),
    IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
    IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined)),
    IconButton(onPressed: () {}, icon: const Icon(Icons.delete_outline)),
  ];
  List<Text> labelList = const <Text>[
    Text('Clone Add'),
    Text('Custom Add'),
    Text('Edit'),
    Text('Delete'),
  ];

  buttonList = List.generate(
      buttonList.length,
      (index) => Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buttonList[index],
                labelList[index],
              ],
            ),
          ));

  showModalBottomSheet(
    showDragHandle: true,
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SizedBox(
          height: 150,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: buttonList,
          ),
        ),
      );
    },
  );
}
