import 'package:flutter/material.dart';

class FloatingAddButton extends StatelessWidget {
  final Function() onPressed;
  const FloatingAddButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: FloatingActionButton(
          tooltip: "Add new favourite",
          onPressed: () => onPressed(),
          child: const Icon(Icons.add)),
    );
  }
}
