import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/common/widgets/buttons/text_button.dart';
import 'package:myapp/common/widgets/input_fields/input_field.dart';
import 'package:myapp/core/riverpod/riverpod.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var weightInputField = FutureBuilder(
        future: ref.watch(userData).weight,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final weight = snapshot.data![0]['weight'];
          return InputField(
            hint: weight.toString(),
            label: "Weight",
          );
        });
    var proteinratioInputField = FutureBuilder(
        future: ref.watch(userData).proteinRatio,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final ratio = snapshot.data![0]['protein_ratio'];
          return InputField(
            hint: ratio.toString(),
            label: "Protein Ratio",
          );
        });
    var usernameInputField = FutureBuilder(
        future: ref.watch(userData).userName,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final username = snapshot.data![0]['username'];
          return InputField(
            hint: username.toString(),
            label: "Username",
          );
        });
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
                    ref
                        .read(userData)
                        .updateName(usernameInputField.controller.text);
                    ref.read(userData).updateWeight(
                        double.parse(weightInputField.controller.text));
                    ref.read(userData).updateProteinRatio(
                        double.parse(proteinratioInputField.controller.text));
                  },
                ),
                ButtonText(
                  text: "Change password",
                  onPressed: () {},
                ),
                ButtonText(
                  text: "Sign out",
                  onPressed: () {},
                  style: Style.secondary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
