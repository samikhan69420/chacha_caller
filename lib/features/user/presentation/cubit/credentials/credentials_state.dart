import 'package:equatable/equatable.dart';

abstract class CredentialsState extends Equatable {
  const CredentialsState();
}

class CredentialInitial extends CredentialsState {
  @override
  List<Object?> get props => [];
}

class CredentialLoading extends CredentialsState {
  @override
  List<Object?> get props => [];
}

class CredentialSuccess extends CredentialsState {
  @override
  List<Object?> get props => [];
}

class CredentialFailure extends CredentialsState {
  final String? message;

  const CredentialFailure({required this.message});
  @override
  List<Object?> get props => [];
}
