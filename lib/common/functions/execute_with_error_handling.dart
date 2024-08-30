import 'package:flutter/material.dart';

enum FunctionType { sync, async }

Future<void> executeWithErrorHandling({
  required FunctionType type,
  required BuildContext context,
  required Function action,
}) async {
  try {
    if (type == FunctionType.async) {
      await action();
    } else {
      action();
    }
  } catch (error) {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error.toString()),
        // ignore: use_build_context_synchronously
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }
}
