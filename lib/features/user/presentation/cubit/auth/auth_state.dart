import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class UnAuthenticted extends AuthState {
  @override
  List<Object?> get props => [];
}

class Authenticated extends AuthState {
  final String uid;

  const Authenticated({required this.uid});
  @override
  List<Object?> get props => [uid];
}

class AuthFailure extends AuthState {
  @override
  List<Object?> get props => [];
}
