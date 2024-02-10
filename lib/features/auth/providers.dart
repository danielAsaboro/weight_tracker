import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_tracker/features/auth/data/repo_impl/firebase_auth.dart';
import 'package:weight_tracker/features/auth/domain/repo/auth_repo.dart';
import 'package:weight_tracker/features/auth/domain/usecase/auth_usecase.dart';
import 'package:weight_tracker/features/auth/domain/usecase/auth_usecase_impl.dart';

import 'presentation/controllers/auth.dart';
import 'presentation/controllers/auth_controllers.dart';

final fireBaseAuthRepoProvider = Provider<AuthRepo>((ref) {
  return FireBaseAuthImpl();
});

final authUseCaseProvider = Provider<AuthUseCase>((ref) {
  return AuthUseCaseImpl(ref.watch(fireBaseAuthRepoProvider));
});

final authControllerProvider =
    AsyncNotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

