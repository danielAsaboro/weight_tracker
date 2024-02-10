import '../../presentation/controllers/auth.dart';

abstract class AuthUseCase {
  Future<AuthState> checkIfUserIsSignedInAlready();

  Future<AuthState> signInAnonymously();

  Future<AuthState> signOut();

}
