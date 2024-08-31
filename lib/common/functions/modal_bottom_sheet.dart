import 'package:flutter/material.dart';

late final List<Widget> buttonList;

void customModelBottomSheet({
  required BuildContext context,
  required List<Widget> buttonList,
}) {
  showModalBottomSheet(
    showDragHandle: true,
    context: context,
    builder: (context) {
      return SizedBox(
        height: 150,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: buttonList,
        ),
      );
    },
  );
}
