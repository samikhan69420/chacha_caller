import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:chacha_caller/features/app/const/app_auth_exception.dart';
import 'package:chacha_caller/features/user/domain/entity/user_entity.dart';
import 'package:chacha_caller/features/user/domain/usecase/sign_in_user_usecase.dart';
import 'package:chacha_caller/features/user/domain/usecase/sign_up_user_usecase.dart';
import 'package:chacha_caller/features/user/presentation/cubit/credentials/credentials_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CredentialsCubit extends Cubit<CredentialsState> {
  final SignInUserUsecase signInUserUsecase;
  final SignUpUserUsecase signUpUserUsecase;

  CredentialsCubit({
    required this.signInUserUsecase,
    required this.signUpUserUsecase,
  }) : super(CredentialInitial());

  Future<void> signInUser(
      {required String email, required String password}) async {
    emit(CredentialLoading());
    try {
      await signInUserUsecase.call(
        UserEntity(
          email: email,
          password: password,
        ),
      );
      emit(CredentialSuccess());
    } on FirebaseAuthException catch (e) {
      emit(CredentialFailure(message: e.message ?? e.code));
    } on SocketException catch (e) {
      emit(CredentialFailure(message: e.message));
    } on AppAuthException catch (e) {
      emit(CredentialFailure(message: e.message));
    } catch (e) {
      emit(CredentialFailure(message: e.toString()));
    }
  }

  Future<void> signUpUser({required UserEntity user}) async {
    emit(CredentialLoading());
    try {
      await signUpUserUsecase.call(
        UserEntity(
          username: user.username,
          password: user.password,
          email: user.email,
          isNotification: false,
          accountType: user.accountType,
        ),
      );
      emit(CredentialSuccess());
    } on FirebaseAuthException catch (e) {
      emit(CredentialFailure(message: e.message ?? e.code));
    } on SocketException catch (e) {
      emit(CredentialFailure(message: e.message));
    } catch (e) {
      emit(CredentialFailure(message: e.toString()));
    }
  }
}
