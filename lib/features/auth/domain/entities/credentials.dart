class UserCredentials {
  final String accessToken;
  final String refreshToken;
  final DateTime expiryDate;

  UserCredentials(
    this.accessToken,
    this.refreshToken,
    this.expiryDate,
  );

  bool get isActive {
    return DateTime.now().isBefore(expiryDate);
  }
}
