import 'package:flutter/material.dart';

class IntakeList extends StatelessWidget {
  final List intake;

  const IntakeList({super.key, required this.intake});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: intake.length,
      itemBuilder: (context, index) {
        final item = intake[index];
        List<Widget> subtitles = [];

        item.forEach((key, value) {
          if (key.startsWith('quantity')) {
            final weightKey = 'weight${key.substring(8)}';
            final proteinsKey = 'proteins${key.substring(8)}';
            if (item.containsKey(weightKey)) {
              subtitles.add(
                Text(
                  '${item[proteinsKey]}g  •  $value x ${item[weightKey]}g',
                ),
              );
            }
          }
        });

        return ListTile(
          title: Text(item['name']),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: subtitles,
          ),
        );
      },
    );
  }
}
