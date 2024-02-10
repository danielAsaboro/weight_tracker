abstract class AppUser {
  final String userId;
  final String? email;
  final bool isVerified;
  final bool isAnonymous;
  final String? phoneNumber;
  final String? avatarUrl;

  AppUser(
    this.userId,
    this.email,
    this.isVerified,
    this.isAnonymous,
    this.phoneNumber,
    this.avatarUrl,
  );
}
