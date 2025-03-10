import 'package:chacha_caller/features/user/domain/entity/user_entity.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoaded extends UserState {
  final UserEntity user;

  const UserLoaded({required this.user});

  @override
  List<Object?> get props => [user];
}

class UserLoading extends UserState {
  @override
  List<Object?> get props => [];
}

class UserFailure extends UserState {
  @override
  List<Object?> get props => [];
}
