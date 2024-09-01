import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/main.dart';

Future<dynamic> deleteDialog({
  required String mealType,
  required ChangeNotifierProvider provider,
  required BuildContext context,
  required String id,
  required WidgetRef ref,
  Function()? extraAction,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this item?'),
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
              await supabase.from(mealType).delete().eq('id', id);
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
              ref.invalidate(provider);
              if (extraAction != null) {
                extraAction();
              }
            },
          ),
        ],
      );
    },
  );
}
