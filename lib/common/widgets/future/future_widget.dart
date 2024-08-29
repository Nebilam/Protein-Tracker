import 'package:flutter/material.dart';

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
          return const Center(child: CircularProgressIndicator());
        }
        final data = snapshot.data!;
        return builder(context, data);
      },
    );
  }
}
