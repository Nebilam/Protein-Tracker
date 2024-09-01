import 'package:flutter/material.dart';
import 'package:myapp/common/widgets/buttons/sign_out.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SignOutWidget(),
        ],
      ),
    );
  }
}
