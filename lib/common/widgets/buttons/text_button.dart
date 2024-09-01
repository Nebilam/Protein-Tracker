import 'package:flutter/material.dart';

enum Style { primary, secondary }

class ButtonText extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final double horizontalPadding;
  final double verticalPadding;
  final Style style;

  const ButtonText({
    super.key,
    required this.text,
    required this.onPressed,
    this.horizontalPadding = 10,
    this.verticalPadding = 13,
    this.style = Style.primary,
  });

  Color getColor(BuildContext context) {
    if (style == Style.primary) {
      return Theme.of(context).colorScheme.primaryContainer;
    } else {
      return Theme.of(context).colorScheme.secondaryContainer;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: getColor(context),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: verticalPadding),
            child: Center(
              child: Text(text),
            ),
          ),
        ),
      ),
    );
  }
}
