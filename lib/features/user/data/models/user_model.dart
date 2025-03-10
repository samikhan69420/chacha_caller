// ignore_for_file: overridden_fields

import 'package:chacha_caller/features/user/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  @override
  final String? username;
  @override
  final String? email;
  @override
  final String? password;
  @override
  final String? accountType;
  @override
  final String? uid;
  @override
  final bool? isNotification;

  const UserModel({
    this.username,
    this.email,
    this.password,
    this.accountType,
    this.isNotification,
    this.uid,
  }) : super(
          username: username,
          email: email,
          password: password,
          accountType: accountType,
          isNotification: isNotification,
          uid: uid,
        );

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'accountType': accountType,
      'isNotification': isNotification,
      'uid': uid,
    };
  }

  factory UserModel.from(Map<String, dynamic> data) {
    return UserModel(
      username: data['username'],
      email: data['email'],
      password: data['password'],
      accountType: data['accountType'],
      isNotification: data['isNotification'],
      uid: data['uid'],
    );
  }

  factory UserModel.fromSnapshot(Map<String, dynamic> snapshot) {
    return UserModel(
      username: snapshot['username'],
      email: snapshot['email'],
      password: snapshot['password'],
      accountType: snapshot['accountType'],
      isNotification: snapshot['isNotification'],
      uid: snapshot['uid'],
    );
  }
}
