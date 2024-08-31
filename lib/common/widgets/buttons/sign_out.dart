import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/widgets/buttons/text_button.dart';
import 'package:myapp/presentation/pages/authentication/login_signup/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignOutWidget extends StatefulWidget {
  final Style style;
  const SignOutWidget({super.key, this.style = Style.primary});

  @override
  SignOutWidgetState createState() => SignOutWidgetState();
}

class SignOutWidgetState extends State<SignOutWidget> {
  Future<void> _signOut() async {
    try {
      await Supabase.instance.client.auth.signOut();
    } catch (error) {
      if (mounted) {
        AnimatedSnackBar.material(
          error.toString(),
          type: AnimatedSnackBarType.error,
          snackBarStrategy: RemoveSnackBarStrategy(),
          duration: const Duration(seconds: 3),
          // ignore: use_build_context_synchronously
        ).show(context);
      }
    } finally {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ButtonText(
      text: "Sign out",
      style: widget.style,
      onPressed: () {
        _signOut();
      },
    );
  }
}
