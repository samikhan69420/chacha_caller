class UserEntity {
  final String? username;
  final String? email;
  final String? password;
  final String? accountType;
  final String? uid;

  final bool? isNotification;

  const UserEntity({
    this.username,
    this.email,
    this.password,
    this.accountType,
    this.isNotification,
    this.uid,
  });
}
