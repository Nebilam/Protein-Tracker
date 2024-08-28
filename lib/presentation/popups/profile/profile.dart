import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/common/widgets/buttons/text_button.dart';
import 'package:myapp/core/riverpod/riverpod.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile Settings"),
        ),
        body: Column(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                ref.read(proteins).incrementFunc(increment: 1);
              },
              label: const Text("Remove"),
            ),
            Text("${ref.watch(mealData).lunchData}"),
            ButtonText(
                text: "Get Profile",
                onPressed: () {
                  ref.read(userData).updateName("Otis Lammertyn");
                  // ignore: unused_result
                  ref.refresh(userData);
                }),
          ],
        ));
  }
}
