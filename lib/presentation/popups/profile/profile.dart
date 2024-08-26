import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/core/riverpod/riverpod.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile Settings"),
        ),
        body: ElevatedButton.icon(
          onPressed: () {
            ref.read(proteins).incrementFunc(increment: 1);
          },
          label: const Text("Remove"),
        ));
  }
}
