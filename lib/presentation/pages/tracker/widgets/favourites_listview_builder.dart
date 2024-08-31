import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/presentation/pages/tracker/functions/modal_bottom_sheet.dart';
import 'package:myapp/core/riverpod/riverpod.dart';
import 'package:myapp/main.dart';

class FavouritesListviewBuilder extends ConsumerWidget {
  final List list;
  final String mealType;
  const FavouritesListviewBuilder({
    super.key,
    required this.list,
    required this.mealType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        List<Widget> subtitles1 = [];

        item.forEach((key, value) {
          if (key.startsWith('protein_density')) {
            const proteinDensityKey = 'protein_density';
            const weightKey = 'weight';
            final double proteins = double.parse(
                (item[proteinDensityKey] * item[weightKey]).toStringAsFixed(2));
            if (item.containsKey(weightKey)) {
              subtitles1.add(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${proteins}g",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "1 x ${item[weightKey]}g",
                    )
                  ],
                ),
              );
            }
          }
        });
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            title: Text(item['name']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: subtitles1,
            ),
            onTap: () {
              customModelBottomSheet(
                ref: ref,
                context: context,
                id: item['id'],
                name: item['name'],
                mealType: mealType,
                weight: item['weight'],
                proteinDensity: item['protein_density'],
              );
            },
            onLongPress: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirm Delete'),
                    content: const Text(
                        'Are you sure you want to delete this item?'),
                    actions: [
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Delete'),
                        onPressed: () async {
                          await supabase
                              .from('${mealType}_list')
                              .delete()
                              .eq('id', item['id']);
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                          ref.invalidate(mealDataOptions);
                        },
                      ),
                    ],
                  );
                },
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            tileColor: Theme.of(context).colorScheme.secondaryContainer,
          ),
        );
      },
    );
  }
}
