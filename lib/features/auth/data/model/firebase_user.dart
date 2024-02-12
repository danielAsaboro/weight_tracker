import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user.dart';

class FirebaseAppUser extends AppUser {
  FirebaseAppUser(
    super.userId,
    super.email,
    super.isVerified,
    super.isAnonymous,
    super.phoneNumber,
    super.avatarUrl,
  );

  factory FirebaseAppUser.fromJson(User firebaseUser) {
    return FirebaseAppUser(
      firebaseUser.uid,
      firebaseUser.email,
      firebaseUser.emailVerified,
      firebaseUser.isAnonymous,
      firebaseUser.phoneNumber,
      firebaseUser.photoURL,
    );
  }
}
