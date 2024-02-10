import 'package:weight_tracker/features/auth/domain/enums/auth_state.dart';

import '../entities/user.dart';

abstract interface class AuthRepo {
  Future<
      ({
        AuthFailure? authFailure,
        AppUser? userDetails,
      })> signInAnonymously();
  Future<void> signOut();
}
