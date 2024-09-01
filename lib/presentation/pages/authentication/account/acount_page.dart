import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/common/widgets/buttons/text_button.dart';
import 'package:myapp/common/widgets/input_fields/input_field.dart';
import 'package:myapp/core/navbar/nav_bar.dart';
import 'package:myapp/core/riverpod/riverpod.dart';

class AccountPage extends ConsumerWidget {
  final weightInputField = InputField(hint: "Weight");
  final proteinratioInputField = InputField(hint: "Protein Ratio");
  final usernameInputField = InputField(hint: "Username");

  AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
        automaticallyImplyLeading: false,
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
                      Expanded(child: weightInputField),
                      const SizedBox(width: 12),
                      Expanded(child: proteinratioInputField),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: usernameInputField),
                const SizedBox(
                  height: 20,
                ),
                ButtonText(
                  text: "Finish",
                  onPressed: () {
                    ref
                        .read(userData)
                        .updateName(usernameInputField.controller.text);
                    ref.read(userData).updateWeight(
                        double.parse(weightInputField.controller.text));
                    ref.read(userData).updateProteinRatio(
                        double.parse(proteinratioInputField.controller.text));
                    ref.invalidate(userData);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
