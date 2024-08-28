import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/common/widgets/buttons/text_button.dart';
import 'package:myapp/common/widgets/input_fields/input_field.dart';
import 'package:myapp/core/riverpod/riverpod.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Settings"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 250,
            ),
            const CircleAvatar(
              radius: 100,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.image),
              label: const Text('Change Profile Picture'),
            ),
            const SizedBox(
              height: 00,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  // const Text("Weight:"),
                  // const SizedBox(width: 12),
                  Expanded(
                    child: InputField(
                      hint: "Weight",
                    ),
                  ),
                  const SizedBox(width: 12),
                  // const Text("Protein ratio:"),
                  // const SizedBox(width: 12),
                  Expanded(
                    child: InputField(
                      hint: "Protein ratio",
                    ),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: InputField(hint: "Weight"),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: InputField(hint: "Protein ratio"),
            // ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InputField(
                hint: "Username",
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ButtonText(
              text: "Update",
              onPressed: () {},
            ),
            const SizedBox(
              height: 20,
            ),
            // const Spacer(),
            ButtonText(
              text: "Change password",
              onPressed: () {},
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonText(
              text: "Sign out",
              onPressed: () {},
              style: Style.secondary,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
