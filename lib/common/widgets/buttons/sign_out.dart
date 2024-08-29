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
    } on AuthException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(error.message),
            backgroundColor: Theme.of(context).colorScheme.error));
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text("Unexpected error occurred"),
            backgroundColor: Theme.of(context).colorScheme.error));
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
