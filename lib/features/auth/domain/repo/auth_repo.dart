abstract interface class AuthRepo {
  Future<void> signInAnonymously();
  Future<void> signOut();
}
