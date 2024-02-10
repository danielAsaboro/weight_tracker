import 'package:firebase_auth/firebase_auth.dart';
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
      final result = await _auth.signInAnonymously();
      final lol = FirebaseUser.fromJson(result.user!);
      return (
        authFailure: null,
        userDetails: lol,
      );
      // TODO
      // not enough error handling cause of case;
    } catch (e) {
      print(e.toString());
      //TODO
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      // TODO
      rethrow;
    }
  }
}
