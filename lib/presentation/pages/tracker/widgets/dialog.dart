import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/common/widgets/future/future_widget.dart';
import 'package:myapp/common/widgets/input_fields/input_field.dart';
import 'package:myapp/core/riverpod/riverpod.dart';
import 'package:myapp/presentation/pages/tracker/widgets/dialog_list_view.dart';

enum ActionType { add, edit, customAdd }

class FavouriteDialog extends ConsumerWidget {
  final ActionType actionType;
  final String title;
  final String mealType;
  final String id;

  const FavouriteDialog({
    super.key,
    required this.actionType,
    required this.title,
    required this.mealType,
    this.id = 'empty',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (actionType == ActionType.add) {
      return Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: DialogListView(
                actionType: actionType,
                title: title,
                mealType: mealType,
                nameInputField: InputField(hint: "Name"),
                weightInputField: InputField(hint: "Weight (g)"),
                proteinDensityInputField: InputField(hint: "Protein % (%)"),
              )));
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: CustomFutureBuilder(
              future: ref.read(mealDataOptions).getItem(mealType, id),
              builder: (context, data) {
                TextEditingController nameController = TextEditingController();
                nameController.text = data[0]['name'];
                final nameInputField = InputField(
                  hint: "Name",
                  controller: nameController,
                );

                TextEditingController weightController =
                    TextEditingController();
                weightController.text = data[0]['weight'].toString();
                final weightInputField = InputField(
                  hint: "Weight (g)",
                  controller: weightController,
                );

                TextEditingController proteinDensityController =
                    TextEditingController();
                proteinDensityController.text =
                    (data[0]['protein_density'] * 100).toString();
                final proteinDensityInputField = InputField(
                  hint: "Protein % (%)",
                  controller: proteinDensityController,
                );

                return DialogListView(
                  actionType: actionType,
                  title: title,
                  id: id,
                  mealType: mealType,
                  nameInputField: nameInputField,
                  weightInputField: weightInputField,
                  proteinDensityInputField: proteinDensityInputField,
                );
              }),
        ),
      );
    }
  }
}
