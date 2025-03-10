import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chacha_caller/features/user/domain/usecase/get_single_user_usecase.dart';
import 'package:chacha_caller/features/user/presentation/cubit/user/user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetSingleUserUsecase getSingleUserUsecase;

  UserCubit({
    required this.getSingleUserUsecase,
  }) : super(UserInitial());

  Future<void> getSingleUser({required String uid}) async {
    emit(UserLoading());
    try {
      final streamResponse = getSingleUserUsecase.call(uid);
      streamResponse.listen((user) {
        emit(UserLoaded(user: user.single));
      });
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }
}
