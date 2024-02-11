import 'package:firebase_auth/firebase_auth.dart';
import 'package:weight_tracker/features/auth/data/auth_exceptions.dart';
import 'package:weight_tracker/features/auth/data/model/firebase_user.dart';
import 'package:weight_tracker/features/auth/domain/entities/user.dart';
import 'package:weight_tracker/features/auth/domain/enums/auth_state.dart';
import 'package:weight_tracker/features/auth/domain/repo/auth_repo.dart';

class FireBaseAuthImpl implements AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<
      ({
        AuthFailure? authFailure,
        AppUser userDetails,
      })> signInAnonymously() async {
    try {
      final authResult = await _auth.signInAnonymously();
      return (
        authFailure: null,
        userDetails: FirebaseUser.fromJson(authResult.user!),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "operation-not-allowed") {
        throw SignInAnonymouslyNotAllow("Anonymous SignIn N=nO longer Allowed");
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
