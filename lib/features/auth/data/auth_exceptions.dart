class AuthExceptions implements Exception {
  final String message;

  AuthExceptions(this.message);
}

class SignInAnonymouslyNotAllow implements Exception {
  final String message;
  SignInAnonymouslyNotAllow(this.message);
}
