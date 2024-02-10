import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user.dart';

class FirebaseUser extends AppUser {
  FirebaseUser(
    super.userId,
    super.email,
    super.isVerified,
    super.isAnonymous,
    super.phoneNumber,
    super.avatarUrl,
  );

  factory FirebaseUser.fromJson(User firebaseUser) {
    return FirebaseUser(
      firebaseUser.uid,
      firebaseUser.email,
      firebaseUser.emailVerified,
      firebaseUser.isAnonymous,
      firebaseUser.phoneNumber,
      firebaseUser.photoURL,
    );
  }
}
