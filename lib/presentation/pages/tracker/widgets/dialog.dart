import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/common/widgets/buttons/text_button.dart';
import 'package:myapp/common/widgets/future/future_widget.dart';
import 'package:myapp/common/widgets/input_fields/input_field.dart';
import 'package:myapp/core/riverpod/riverpod.dart';

class FavouriteDialog extends ConsumerWidget {
  final String title;
  final String mealType;

  const FavouriteDialog(
      {super.key, required this.title, required this.mealType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weightInputField = InputField(hint: "Weight");
    final proteinDensityInputField = InputField(hint: "Protein Percentage");
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: CustomFutureBuilder(
            future: ref.watch(mealDataOptions).breakfastData,
            builder: (context, data) {
              TextEditingController nameController = TextEditingController();
              nameController.text = data[0]['name'];
              final nameInputField = InputField(
                hint: "Name",
                controller: nameController,
              );

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
                      ref.read(mealDataOptions).addNew(
                          mealType,
                          nameInputField.controller.text.toString(),
                          double.parse(weightInputField.controller.text),
                          double.parse(
                                  proteinDensityInputField.controller.text) /
                              100.toDouble());
                      ref.invalidate(mealDataOptions);

                      Navigator.pop(context);
                    },
                  )
                ],
              );
            }),
      ),
    );
  }
}
