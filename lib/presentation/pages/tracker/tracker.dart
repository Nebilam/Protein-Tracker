// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myapp/presentation/pages/home/single_choice_selection.dart';

class Tracker extends StatelessWidget {
  const Tracker({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SingleChoice(
        container: SelectionChoice.favourites,
      ),
    );
  }
}
