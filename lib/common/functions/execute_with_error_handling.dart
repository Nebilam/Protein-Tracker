import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  } on AuthException catch (error) {
    AnimatedSnackBar.material(
      error.message,
      type: AnimatedSnackBarType.error,
      snackBarStrategy: RemoveSnackBarStrategy(),
      duration: const Duration(seconds: 3),
      // ignore: use_build_context_synchronously
    ).show(context);
  } catch (error) {
    AnimatedSnackBar.material(
      error.toString(),
      type: AnimatedSnackBarType.error,
      snackBarStrategy: RemoveSnackBarStrategy(),
      duration: const Duration(seconds: 3),
      // ignore: use_build_context_synchronously
    ).show(context);
  }
}
