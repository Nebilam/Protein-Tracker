import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/common/widgets/buttons/sign_out.dart';
import 'package:myapp/common/widgets/buttons/text_button.dart';
import 'package:myapp/common/widgets/input_fields/input_field.dart';
import 'package:myapp/core/riverpod/riverpod.dart';

class Profile extends ConsumerWidget {
  final weightInputField = InputField(hint: "Weight");
  final proteinratioInputField = InputField(hint: "Protein Ratio");
  final usernameInputField = InputField(hint: "Username");
  Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Settings"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 100,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.image),
                  label: const Text('Change Profile Picture'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: weightInputField,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: proteinratioInputField,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: usernameInputField,
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonText(
                  text: "Update",
                  onPressed: () {
                    if (usernameInputField.controller.text != '') {
                      ref
                          .read(userData)
                          .updateName(usernameInputField.controller.text);
                    }
                    if (weightInputField.controller.text != '') {
                      ref.read(userData).updateWeight(
                          double.parse(weightInputField.controller.text));
                    }
                    if (proteinratioInputField.controller.text != '') {
                      ref.read(userData).updateProteinRatio(
                          double.parse(proteinratioInputField.controller.text));
                    }
                    // ignore: unused_result
                    ref.refresh(userData);
                    Navigator.of(context).pop();
                  },
                ),
                ButtonText(
                  text: "Change password",
                  onPressed: () {},
                ),
                const SignOutWidget(
                  style: Style.secondary,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
