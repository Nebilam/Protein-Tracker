// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myapp/common/widgets/selection/single_choice_selection.dart';

class Tracker extends StatelessWidget {
  const Tracker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tracker',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SingleChoice(
          container: SelectionChoice.favourites,
        ),
      ),
    );
  }
}
