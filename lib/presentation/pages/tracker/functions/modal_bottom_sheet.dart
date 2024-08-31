import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/core/riverpod/riverpod.dart';

late final String id;
late final String name;
late final String mealType;
late final num weight;
late final num proteinDensity;

void customModelBottomSheet({
  required BuildContext context,
  required WidgetRef ref,
  required String id,
  required String name,
  required String mealType,
  required num weight,
  required num proteinDensity,
}) {
  List<Widget> buttonList = <Widget>[
    IconButton(
        onPressed: () {
          ref.read(mealData).cloneAdd(mealType, name, proteinDensity, weight);
          Navigator.pop(context);
        },
        icon: const Icon(Icons.copy)),
    IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
    IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined)),
    IconButton(
        onPressed: () {
          ref.read(mealDataOptions).delete('${mealType}_list', id);
          Navigator.pop(context);
          ref.invalidate(mealDataOptions);
        },
        icon: const Icon(Icons.delete_outline)),
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
  ref.invalidate(mealData);
}
