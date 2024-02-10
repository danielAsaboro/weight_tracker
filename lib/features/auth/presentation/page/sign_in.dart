import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_tracker/features/auth/presentation/controllers/auth.dart';
import 'package:weight_tracker/features/auth/providers.dart';
import 'package:weight_tracker/features/weight/presentation/components/weight_list.dart';
import 'package:weight_tracker/shared/presentation/components/app_button.dart';

class SigInPage extends ConsumerStatefulWidget {
  const SigInPage({super.key});

  @override
  ConsumerState<SigInPage> createState() => _SigInPageState();
}

class _SigInPageState extends ConsumerState<SigInPage> {
  @override
  Widget build(BuildContext context) {
    ref.listen(authControllerProvider, (previous, next) {
      if (next.value! == AuthState.signedIn) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (
              context,
            ) =>
                    const WeightListScreen()));
      }
    });

    final authController = ref.watch(authControllerProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: AppButton(
            onPressed: () async {
              try {
                await ref
                    .read(authControllerProvider.notifier)
                    .signInAnonymously();
              } catch (e) {
                // TODO
                print(e.toString());
              }
            },
            child: authController.isLoading
                ? const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Signing You In"),
                      SizedBox(
                        width: 40,
                      ),
                      CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ],
                  )
                : const Text("Sign In"),
          ),
        ),
      ),
    );
  }
}
