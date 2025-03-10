part of 'calling_cubit.dart';

abstract class CallingState extends Equatable {
  const CallingState();

  @override
  List<Object> get props => [];
}

class CallingInitial extends CallingState {
  @override
  List<Object> get props => [];
}

class CallingLoading extends CallingState {
  @override
  List<Object> get props => [];
}

class CallingLoaded extends CallingState {
  final Stream<List<UserEntity>>? users;

  const CallingLoaded({this.users});

  @override
  List<Object> get props => [users!];
}

class CallingSuccess extends CallingState {
  @override
  List<Object> get props => [];
}

class CallingFailure extends CallingState {
  final String message;

  const CallingFailure({required this.message});
  @override
  List<Object> get props => [message];
}
