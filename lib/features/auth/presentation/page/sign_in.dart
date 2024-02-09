import 'package:flutter/material.dart';
import 'package:weight_tracker/features/auth/data/repo_impl/firebase_auth.dart';
import 'package:weight_tracker/shared/presentation/components/app_button.dart';

class SigInPage extends StatefulWidget {
  const SigInPage({super.key});

  @override
  State<SigInPage> createState() => _SigInPageState();
}

class _SigInPageState extends State<SigInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppButton(
          onPressed: () async {
            try {
              await FireBaseAuthImpl().signInAnonymously();
            } catch (e) {
              print(e.toString());
            }
          },
          child: Text("Sign In"),
        ),
      ),
    );
  }
}
