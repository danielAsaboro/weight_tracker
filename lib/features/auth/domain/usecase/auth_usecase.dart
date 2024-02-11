import '../../presentation/controllers/auth.dart';
import '../entities/user.dart';

abstract class AuthUseCase {
  late final AppUser user;

  Future<AuthState> checkIfUserIsSignedInAlready();

  Future<AuthState> signInAnonymously();

  Future<AuthState> signOut();
}
