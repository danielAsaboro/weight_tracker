import 'package:weight_tracker/features/auth/domain/enums/auth_state.dart';
import 'package:weight_tracker/features/auth/domain/repo/auth_repo.dart';
import 'package:weight_tracker/features/auth/presentation/controllers/auth.dart';

import 'auth_usecase.dart';

class AuthUseCaseImpl implements AuthUseCase {
  final AuthRepo _authRepository;

  AuthUseCaseImpl(this._authRepository);

  @override
  Future<AuthState> checkIfUserIsSignedInAlready() async{
    
    return AuthState.signedOut;
    // // TODO: implement checkIfUserIsSignedInAlready
    // throw UnimplementedError();
  }

  @override
  Future<AuthState> signInAnonymously() async {
    try {
      final result = await _authRepository.signInAnonymously();
      if (result.authFailure != null) {
        // TODO
        throw AuthFailure.generic;
      } else {
        return AuthState.signedIn;
      }
    } catch (e) {
      // TODO;
      rethrow;
    }
  }

  @override
  Future<AuthState> signOut() async {
    try {
      await _authRepository.signOut();
      return AuthState.signedOut;
    } catch (e) {
      // TODO;
      rethrow;
    }
  }
}
