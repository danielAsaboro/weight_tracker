import 'package:weight_tracker/features/auth/domain/entities/user.dart';
import 'package:weight_tracker/features/auth/domain/enums/auth_state.dart';
import 'package:weight_tracker/features/auth/domain/repo/auth_repo.dart';
import 'package:weight_tracker/features/auth/presentation/controllers/auth.dart';

import 'auth_usecase.dart';

class AuthUseCaseImpl implements AuthUseCase {
  final AuthRepo _authRepository;
  @override
  late AppUser user;

  AuthUseCaseImpl(this._authRepository);

  @override
  Future<AuthState> checkIfUserIsSignedInAlready() async {
    //TODO need to check if signedIn
    // final result = await _authRepository.
    return AuthState.signedOut;
  }

  @override
  Future<AuthState> signInAnonymously() async {
    try {
      final result = await _authRepository.signInAnonymously();
      if (result.authFailure != null) {
        throw AuthFailure.generic;
      } else {
        user = result.userDetails!;
        return AuthState.signedIn;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthState> signOut() async {
    try {
      await _authRepository.signOut();
      return AuthState.signedOut;
    } catch (e) {
      rethrow;
    }
  }
}
