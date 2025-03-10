import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chacha_caller/features/app/const/app_auth_exception.dart';
import 'package:chacha_caller/features/calling/domain/usecases/get_workers_usecase.dart';
import 'package:chacha_caller/features/calling/domain/usecases/initial_app_start_usecase.dart';
import 'package:chacha_caller/features/calling/domain/usecases/onesignal_login_usecase.dart';
import 'package:chacha_caller/features/calling/domain/usecases/send_notification_usecase.dart';
import 'package:chacha_caller/features/user/domain/entity/user_entity.dart';
import 'package:equatable/equatable.dart';

part 'calling_state.dart';

class CallingCubit extends Cubit<CallingState> {
  final InitialAppStartUsecase initialAppStartUsecase;
  final OnesignalLoginUsecase onesignalLoginUsecase;
  final SendNotificationUsecase sendNotificationUsecase;
  final GetWorkersUsecase getWorkersUsecase;

  CallingCubit({
    required this.getWorkersUsecase,
    required this.initialAppStartUsecase,
    required this.onesignalLoginUsecase,
    required this.sendNotificationUsecase,
  }) : super(CallingInitial());

  Future<void> initApp() async {
    emit(CallingLoading());
    try {
      await initialAppStartUsecase.call();
      final streamResponse = getWorkersUsecase.call();
      emit(CallingLoaded(users: streamResponse));
    } on SocketException catch (e) {
      emit(CallingFailure(message: e.message));
    } on AppAuthException catch (e) {
      emit(CallingFailure(message: e.message));
    }
  }

  Future<void> oneSignalLogin(String uid) async {
    emit(CallingLoading());
    try {
      await onesignalLoginUsecase.call(uid);
      final streamResponse = getWorkersUsecase.call();
      emit(CallingLoaded(users: streamResponse));
    } on SocketException catch (e) {
      emit(CallingFailure(message: e.message));
    } on AppAuthException catch (e) {
      emit(CallingFailure(message: e.message));
    }
  }

  Future<void> sendNotification(String message, List<UserEntity> users) async {
    emit(CallingLoading());
    try {
      await sendNotificationUsecase.call(message, users);
      final streamResponse = getWorkersUsecase.call();
      emit(CallingLoaded(users: streamResponse));
    } on SocketException catch (e) {
      emit(CallingFailure(message: e.message));
    } on AppAuthException catch (e) {
      emit(CallingFailure(message: e.message));
    }
  }

  Future<void> getWorkers() async {
    emit(CallingLoading());
    try {
      final streamResponse = getWorkersUsecase.call();
      emit(CallingLoaded(users: streamResponse));
    } catch (e) {
      emit(CallingFailure(message: e.toString()));
    }
  }
}
