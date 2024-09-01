import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/common/widgets/buttons/text_button.dart';
import 'package:myapp/common/widgets/input_fields/input_field.dart';
import 'package:myapp/core/riverpod/riverpod.dart';
import 'package:myapp/presentation/pages/tracker/widgets/dialog.dart';

class DialogListView extends ConsumerWidget {
  final ActionType actionType;
  final String title;
  final String mealType;
  final String? id;
  final String? name;
  final String? weight;
  final String? proteinDensity;

  final InputField nameInputField;
  final InputField weightInputField;
  final InputField proteinDensityInputField;

  const DialogListView({
    super.key,
    required this.actionType,
    required this.title,
    required this.mealType,
    required this.nameInputField,
    required this.weightInputField,
    required this.proteinDensityInputField,
    this.id,
    this.name,
    this.weight,
    this.proteinDensity,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: nameInputField,
        ),
        const SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(children: [
            Expanded(child: weightInputField),
            const SizedBox(width: 12),
            Expanded(child: proteinDensityInputField),
          ]),
        ),
        const SizedBox(
          height: 12,
        ),
        ButtonText(
          text: title,
          onPressed: () {
            if (actionType == ActionType.add) {
              ref.read(mealDataOptions).addNew(
                  mealType,
                  nameInputField.controller.text.toString(),
                  double.parse(weightInputField.controller.text),
                  double.parse(proteinDensityInputField.controller.text) /
                      100.toDouble());
            } else if (actionType == ActionType.edit) {
              ref.read(mealDataOptions).update(
                  mealType,
                  id,
                  nameInputField.controller.text.toString(),
                  double.parse(weightInputField.controller.text),
                  double.parse(proteinDensityInputField.controller.text) /
                      100.toDouble());
            } else if (actionType == ActionType.customAdd) {
              ref.read(mealData).cloneAdd(
                    mealType,
                    nameInputField.controller.text.toString(),
                    double.parse(proteinDensityInputField.controller.text) /
                        100.toDouble(),
                    double.parse(weightInputField.controller.text),
                  );
            }
            ref.invalidate(mealDataOptions);

            Navigator.pop(context);
            Navigator.pop(context);
            ref.invalidate(mealDataOptions);
          },
        )
      ],
    );
  }
}
