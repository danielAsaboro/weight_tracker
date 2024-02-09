import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:weight_tracker/features/auth/domain/repo/auth_repo.dart';

class FireBaseAuthImpl implements AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Future<void> signInAnonymously() async {
    try {
      final result = await _auth.signInAnonymously();
      result.user;
      print(result.user);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
