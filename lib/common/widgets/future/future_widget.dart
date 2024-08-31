import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomFutureBuilder extends StatelessWidget {
  final Future future;
  final Widget Function(BuildContext context, dynamic data) builder;

  const CustomFutureBuilder({
    super.key,
    required this.future,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
              child:
                  SpinKitPulse(color: Theme.of(context).colorScheme.primary));
        }
        final data = snapshot.data!;
        return builder(context, data);
      },
    );
  }
}
