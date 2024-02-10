import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_tracker/features/auth/presentation/controllers/auth.dart';
import 'package:weight_tracker/features/auth/providers.dart';

class AuthNotifier extends AsyncNotifier<AuthState> {
  @override
  FutureOr<AuthState> build() {
    // TODO:
    ref.read(authUseCaseProvider).checkIfUserIsSignedInAlready();
    return AuthState.signedOut;
  }

  Future<void> signInAnonymously() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async => ref.read(authUseCaseProvider).signInAnonymously(),
    );
  }

  Future<void> signOut() async {
    state = await AsyncValue.guard(
      () async => ref.read(authUseCaseProvider).signOut(),
    );
  }
}
